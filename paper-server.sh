#!/bin/bash
echo "do you agree to the Minecraft EULA (y/n)?"
read r1
if [[ $r1 =~ ^[Yy]$ ]]; then
    ## Color codes for making text fancy
    R='\033[0;31m'
    G='\033[0;32m'
    Y='\033[1;33m'
    NC='\033[0m'
    ## how its able to pull latest version of version you want
    sudo apt install jq -y
    clear
    echo -e "$R !!!WARNING!!! $Y YOU MIGHT ENCOUNTER BUGS ON THE LATEST MINECRAFT VERSION AND PAPER WILL NOT GIVE YOU SUPPORT ON ANY PREVIOUS VERSIONS, OTHER THAN THE LATEST $NC"
    sleep 2
    echo "what version of minecraft do you want (MC Version 1.8.8+)?"
    read version
    echo "How many GB of ram do you want to allocate to your server?"
    read GB
    ram="$(( $GB * 1024))"
    echo "how many threads do you wish to use for your server?"
    read cc
    echo "what should your view distance be? (higher=more performance needed, I reccomend 12)"
    read vdist
    echo "do you want to open the server on a diffrent port than 25565 (y/n)?"
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
    name=paper
    api=https://api.papermc.io/v2
    latest_build="$(curl -sX GET $api/projects/$name/versions/$version/builds -H 'accept: application/json' | jq '.builds [-1].build')"
    download_url=""$api"/projects/"$name"/versions/"$version"/builds/"$latest_build"/downloads/"$name"-"$version"-"$latest_build".jar"
    wget $download_url
    

    echo -e "Please choose what kind of paper server this will be?"
    PS3="Choose an option:"
    select option in "1||Standalone" "2||Bungeecord"; do
    case $option in
        "1||Standalone")
        echo "You selected Option 1"
        break
        ;;
        "2||Bungeecord")
        echo "You selected Option 2"
        break
        ;;
        *)
        echo "Invalid selection"
        ;;
    esac
    done



    

else
    echo "fortnite battle pass. Anyways canceled installation"
    exit
fi
echo "balls"