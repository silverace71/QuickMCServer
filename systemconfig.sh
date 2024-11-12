#!/bin/bash

# This script configures the system for your server

echo "Would you like to run autoconfig? (y/n)"
read r1
if [[ $auto =~ ^[Yy]$ ]]; then

port=25565

## Ram allocation section

total_ram=$(free -g | awk '/^Mem:/{print $2}')
max_allowed=$((total_ram - 1)) # Leave at least 1GB for the OS
ram="$(( $max_allowed * 1024))"

## Thread allocation section

total_threads=$(nproc)
cc=$((total_threads - 1))

## View distance section

if [ $cc -le 2 ]; then
    vdist=6
elif [ $cc -ge 4 ] && [ $max_allowed -ge 6 ]; then
    vdist=10 
else
    vdist=6
fi

## jvm arguments section

jvm_args="-Xms128M -Xmx${ram}M"

## I need to change the jvm_arg for better performance, but i need to do some testing before i just slam it in

cat << EOF >> start.sh
#!/bin/bash
java -jar $jvm_args srv.jar nogui
EOF
sudo chmod +x start.sh
mv start.sh $server_dir
cd $server_dir
wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/eula.txt

else
echo "Starting manual configuration"

## Ram allocation section

    echo "How many GB of ram do you want to allocate to your server?"
    read GB

## Check total system RAM
    total_ram=$(free -g | awk '/^Mem:/{print $2}')
    max_allowed=$((total_ram - 1)) # Leave at least 1GB for the systems

    if [ $GB -gt $max_allowed ]; then
        echo "Warning: You're trying to allocate more RAM than recommended."
        echo "Your system has ${total_ram}GB of free RAM. I recommend allocating at most ${max_allowed}GB."
        echo "Do you want to proceed with ${GB}GB anyway? (y/n)"
        read ram_confirm
        if [[ ! $ram_confirm =~ ^[Yy]$ ]]; then
            echo "Please enter a new value for RAM allocation (in GB):"
            read GB
        fi
    fi
    ram="$(( $GB * 1024))"

## Thread allocation section

    # Get the total number of available threads
    total_threads=$(nproc)
    max_allowed=$((total_threads - 1))  # Leave at least one thread for the system

    echo "Your system has $total_threads threads available."
    echo "How many threads do you wish to use for your server? (Max recommended: $max_allowed)"
    read cc

    # Validate user input
    while ! [[ "$cc" =~ ^[0-9]+$ ]] || [ "$cc" -lt 1 ] || [ "$cc" -gt "$total_threads" ]; do
        if [ "$cc" -gt "$max_allowed" ]; then
            echo "Warning: Using $cc threads may impact system performance."
            echo "Do you want to proceed with $cc threads anyway? (y/n)"
            read thread_confirm
            if [[ $thread_confirm =~ ^[Yy]$ ]]; then
                break
            fi
        fi
        echo "Please enter a valid number of threads (1-$total_threads):"
        read cc
    done

## View distance section

    echo "What should your view distance be? (higher=better hardware needed, I recommend somewhere around 10)"
    read vdist
    if [ "$vdist" -gt 10 ]; then
        echo "Warning: Setting view distance above 10 may require significantly more server resources."
        echo "Are you sure you want to set the view distance to $vdist? (y/n)"
        read vdist_confirm
        if [[ ! $vdist_confirm =~ ^[Yy]$ ]]; then
            echo "Please enter a new value for view distance:"
            read vdist
        fi
    fi

## Port section

    echo "do you want to open the server on a diffrent port than the default port: 25565 (y/n)?"
    read r3
    if [[ $r3 =~ ^[Yy]$ ]]; then
    echo "what port do you want to have your MC server on (MAX=65535)?"
    read port
    else
    port=25565
    fi

## JVM arguments section

echo "Choose JVM arguments option:"
echo "1. Default (basic)"
echo "2. Optimized (recommended)"
echo "3. Custom (advanced)"
read -p "Enter your choice (1/2/3): " jvm_choice

case $jvm_choice in
    1)
        jvm_args="-Xms128M -Xmx${ram}M"
        ;;
    2)
        jvm_args="-Xms128M -Xmx${ram}M -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+ParallelRefProcEnabled -XX:ParallelGCThreads=$cc -XX:ConcGCThreads=$cc -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:+UseCompressedOops -XX:+UseVectorCmov -XX:+UseStringDeduplication -XX:+AllowParallelDefineClass -XX:-DontCompileHugeMethods"
        ;;
    3)
        read -p "Enter your custom JVM arguments: " jvm_args
        ;;
    *)
        echo "Invalid choice. Using default arguments."
        jvm_args="-Xms128M -Xmx${ram}M"
        ;;
esac

cat << EOF >> start.sh
#!/bin/bash
java -jar $jvm_args srv.jar nogui
EOF
sudo chmod +x start.sh
mv start.sh $server_dir
cd $server_dir
wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/eula.txt
fi