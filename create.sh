#!/bin/bash

echo "This script will install a Minecraft server on your system. Do you wish to continue? (y/n)?"
read r0
if [[ $r0 =~ ^[Yy]$ ]]; then

## Install some dependencies

sudo apt update && sudo apt-get full-upgrade -y
sudo apt install git -y
if ! command -v java &> /dev/null || [[ $(java -version 2>&1 | awk -F '"' '/version/ {print $2}' | awk -F. '{print $1}') -lt 21 ]]; then
    echo "Java 21 or higher is required. Installing Java 21..."
    sudo apt remove default-jdk openjdk* -y
    sudo apt autoremove -y
    sudo apt update
    sudo apt install openjdk-21-jdk -y
    echo "Java 21 has been installed and set as default."
else
    echo "Java 21 or higher is already installed."
fi
wget $(curl -s https://api.github.com/repos/nothub/mrpack-install/releases/latest  | \
jq -r '.assets[] | select(.name | contains ("linux")) | .browser_download_url')
sudo chmod +x mrpack-install-linux
rm mrpack-install-linux-arm64
./mrpack-install-linux
rm mrpack-install-linux

## Ask EULA for (I think) legal reasons
echo "do you agree to the Minecraft EULA (y/n)?"
read r1
if [[ $r1 =~ ^[Yy]$ ]]; then

## This is the setup for the minecraft server

## Download section
echo "Choose a Minecraft server flavor to install:"
echo "1. Vanilla"
echo "2. Fabric"
echo "3. Quilt"
echo "4. Forge"
echo "5. Neoforge"
echo "6. Paper"
read -p "Enter your choice (1-6): " flavor_choice

case $flavor_choice in
    1) flavor="vanilla" ;;
    2) flavor="fabric" ;;
    3) flavor="quilt" ;;
    4) flavor="forge" ;;
    5) flavor="neoforge" ;;
    6) flavor="paper" ;;
    *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

echo "Hit the enter key to load default values when prompted"
sleep 3

# Get additional parameters for the installation
read -p "Enter the server directory (default: fabric-srv): " server_dir
server_dir=${server_dir:-fabric-srv}  # Default to fabric-srv if empty

read -p "Enter the Minecraft version (default: latest): " mc_version
mc_version=${mc_version:-latest}  # Default to latest if empty

# Execute the installation command
mrpack-install server $flavor --server-dir $server_dir --minecraft-version $mc_version --server-file srv.jar

## Ram allocation section

    echo "How many GB of ram do you want to allocate to your server?"
    read GB

## Check total system RAM
    total_ram=$(free -g | awk '/^Mem:/{print $2}')
    max_allowed=$((total_ram - 2)) # Leave at least 2GB for the system

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

# Start the server to generate files

echo "Starting the server to generate files..."
java -jar $jvm_args srv.jar nogui &  # Run in the background
server_pid=$!  # Capture the PID of the server process
sleep 60  # Wait for 60 seconds
echo "Stopping the server..."
# Send the stop command to the server
echo "stop" | java -jar $jvm_args srv.jar nogui
wait $server_pid  # Wait for the server process to exit

# Update server.properties with the new port and view distance
echo "Updating server.properties..."
if [ -f "server.properties" ]; then
    # Update the port
    sed -i "s/^server-port=.*/server-port=$port/" server.properties
    # Update the view distance
    sed -i "s/^view-distance=.*/view-distance=$vdist/" server.properties
else
    echo "server.properties file not found!"
fi

echo "Use ./start.sh to start the server!"

else
echo "install cancelled"
exit
fi
else
echo "install cancelled"
exit
fi