#!/bin/bash

read -p "Do you wish to use this setup script? (y/n) " -n 1 -r
echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "Do you agree to the minecraft EULA? (y/n) " -n 1 -r
    echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        echo -e "\e[31mwill this be a standalone survival server or part of a bungeecord (waterfall, etc.) network?\e[0m\n\e[36mSTANDALONE: (1)\e[0m\n\e[36mNETWORK SERVER: (2)\e[0m"
        read -p "" -n 1 -r
            if [[ ]]

        echo "what do you want to call your server?"
        read name
        echo "how many cores will you allocate? (2 for hubs|4 for small survival servers|6+ for larger/more heavy servers)"
        read core_count
        echo "How much Megabytes ram will you allocate? Please go in incraments of 1024, only type the number. (1024 for Hub"
        USER_NAME=$(whoami)
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