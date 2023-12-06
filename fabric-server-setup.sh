#!/bin/bash
echo "do you agree to the Minecraft EULA (y/n)?"
read r1
if [[ $r1 =~ ^[Yy]$ ]]; then
    sudo apt install jq -y
    echo "what version of minecraft do you want (MC Version 1.14+)?"
    read ver
    echo "How many GB of ram do you want to allocate to your server?"
    read GB
    ram="$(( $GB * 1024))"
    echo "how many threads do you wish to use for your server?"
    read cc
    echo "what should your view distance be? (higher=more performance needed, I reccomend 12)"
    read vdist
    echo "do you want to open the server on a diffrent port than the default port: 25565 (y/n)?"
    read r3
    if [[ $r3 =~ ^[Yy]$ ]]; then
    echo "what port do you want to have your MC server on (MAX=65535)?"
    read port
    else
    port=25565
    fi
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
    
else
sleep 0
fi