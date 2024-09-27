#!/bin/bash

## Ask EULA for (I think) legal reasons
echo "do you agree to the Minecraft EULA (y/n)?"
read r1
if [[ $r1 =~ ^[Yy]$ ]]; then

## This is the setup for the fabric server

    echo "what version of minecraft do you want (MC Version 1.14+)?"
    read ver

## Ram allocation section

    echo "How many GB of ram do you want to allocate to your server?"
    read GB

## Check total system RAM
    total_ram=$(free -g | awk '/^Mem:/{print $2}')
    max_allowed=$((total_ram - 2)) # Leave at least 2GB for the system

    if [ $GB -gt $max_allowed ]; then
        echo "Warning: You're trying to allocate more RAM than recommended."
        echo "Your system has ${total_ram}GB of RAM. We recommend allocating at most ${max_allowed}GB."
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

    echo "What should your view distance be? (higher=better hardware needed, I recommend 12)"
    read vdist
    if [ "$vdist" -gt 12 ]; then
        echo "Warning: Setting view distance above 12 may require significantly more server resources."
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

## Directory section

    echo "do you want to make a new directory where everything will be stored (y/n)? P.S, you should do this!"
    read r2
    if [[ $r2 =~ ^[Yy]$ ]]; then
        echo "what do you want the folder to be called?"
        read dirname
        mkdir $dirname
        cd $dirname
    else
    sleep 0
    fi

## Download section

    ##Asking user if code got everything right/if they got everything right

    echo "ver is $installer"
    echo "loader is $loader"
    echo "download link is $download"

    echo "are all the options listed above coorect y/n?"



    installer=$(curl -s https://maven.fabricmc.net/net/fabricmc/fabric-installer/ | grep -oP '\b\d{1,3}\.\d{1,3}\.\d{1,3}\b' | sort -r -V | head -1)
    loader=$(curl --silent "https://api.github.com/repos/FabricMC/fabric-loader/releases/latest" | grep -Po "(?<=\"tag_name\": \").*(?=\")")
    download="https://meta.fabricmc.net/v2/versions/loader/$ver/$loader/$installer/server/jar"
    
else
sleep 0
fi