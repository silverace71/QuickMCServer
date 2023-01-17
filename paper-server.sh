#!/bin/bash
read -p "do you wish to run SilverServer setup (y/n)?" -n 1 -r
echo
if [[ $REPLY0 =~ ^[Yy]$ ]]; then
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
    read -p "do you want to make a new directory where everything will be stored (y/n)? P.S, you should do this!" -n 1 -r
    echo
    if [[ $REPLY1 =~ ^[Yy]$ ]]; then
        echo "what do you want the folder to be called?"
        read dirname
        mkdir $dirname
        cd $dirname
    else
    name=paper
    api=https://api.papermc.io/v2
    latest_build="$(curl -sX GET $api/projects/$name/versions/$version/builds -H 'accept: application/json' | jq '.builds [-1].build')"
    download_url=""$api"/projects/"$name"/versions/"$version"/builds/"$latest_build"/downloads/"$name"-"$version"-"$latest_build".jar"
    wget $download_url
    

else
    echo "fortnite battle pass. Anyways canceled installation"
    exit
fi
echo "balls"
