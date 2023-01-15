#!/bin/bash
read -p "do you wish to run SilverServer setup?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m'
    sudo apt install jq -y
    echo "${RED} !!!WARNING!!! ${YELLOW} YOU MIGHT ENCOUNTER BUGS ON THE LATEST MINECRAFT VERSION AND PAPER WILL NOT GIVE YOU SUPPORT ON ANY PREVIOUS VERSIONS, OTHER THAN THE LATEST"
    sleep 5
    echo "${GREEN}what version of minecraft so you want?${NC}"
    read version
    name=paper
    api=https://api.papermc.io/v2
    latest_build="$(curl -sX GET "$api"/projects/"$name"/versions/"$version"/builds -H 'accept: application/json' | jq '.builds [-1].build')"
    revision="$(curl -sX GET "$api"/projects/"$name"/version_group/"$version"/builds -H 'accept: application/json' | jq -r '.builds [-1].version')"
    filename="$(curl -sX GET "$api"/projects/"$name"/version_group/"$version"/builds -H 'accept: application/json' | jq -r '.builds [-1].downloads.application.name')"
    download_url="$api"/projects/"$name"/versions/"$revision"/builds/"$latest_build"/downloads/"$filename"
    wget "$download_url"
else
    echo "fortnite battle pass. Anyways canceled installation"
fi











read -p "Do you wish to use this setup script (1.19.2 mc server)? (y/n) " -n 1 -r
echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Do you agree to the minecraft EULA? (y/n) " -n 1 -r
    echo
        if [[ $REPLY1 =~ ^[Yy]$ ]]; then
        echo -e "\e[31mwill this be a standalone survival server or part of a bungeecord (waterfall, etc.) network?\e[0m\n\e[36mSTANDALONE: (1)\e[0m\n\e[36mNETWORK SERVER: (2)\e[0m"
        read -p "" -n 1 -r
            if [[ $REPLY2 =~ ^[1]$ ]]
            echo "setting up standalone survival server"
            sleep 2
            echo "what do you want to call your server?"
            read name
            mkdir mc-server
            cd mc-server/
            wget https://api.papermc.io/v2/projects/paper/versions/1.19.2/builds/307/downloads/paper-1.19.2-307.jar
            mv paper-1.19.2-307.jar paper.jar
            








            

            echo "what do you want to call your server?"
            read name
            echo "how many cores will you allocate? (2 for hubs|4 for small survival servers|6+ for larger/more heavy servers)"
            read core_count
            echo "How much Megabytes ram will you allocate? Please go in incraments of 1024, only type the number. (1024 for Hub"
            USER_NAME=$(whoami)
            sudo apt install dialog
            sudo apt install nano -y
            sudo apt install apt-utils -y
            sudo apt install openjdk-17-jdk -y
            sudo apt install unzip -y
            wget https://github.com/silverace71/ez-mc-server-hub/archive/refs/heads/main.zip
            unzip main .sh
            cd ez-mc-server-hub-main/
            mv hub /home/$USER_NAME/
            mv start.sh /home/$USER_NAME/hub/
            cd /home/$USER_NAME
            mv hub/ $name
            cd $name/
            sudo chmod +x start.sh
            echo "complete! Use ./start.sh to start up the server (uses 2 cores and 1GiB or ram)"