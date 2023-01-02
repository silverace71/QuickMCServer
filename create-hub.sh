#!/bin/bash

echo "This will take up 200+ MB (and it will grow a larger if you use this as a normal world). do you wish to run this setup tool (y/n)?"
read conf
echo "remember, use this only as a hub (this is also set up as a bungeecord server so it is in offline mode)"
sleep 3
    if [[ $conf == "y" ]]; then
    echo "what do you want to call your server?"
    read name
    USER_NAME=$(whoami)
    sudo apt install nano -y
    sudo apt install apt-utils -y
    sudo apt install openjdk-17-jdk -y
    sudo apt install unzip -y
    wget https://github.com/silverace71/ez-mc-server-hub/archive/refs/heads/main.zip
    unzip main .sh
    cd -- "$(sudo find /home -type d -iname "ez-mc-server-hub-main" -maxdepth 3 2>/dev/null)"
    mv hub /home/$USER_NAME/
    mv start.sh /home/$USER_NAME/hub/
    cd /home/$USER_NAME
    mv hub/ $name
    cd $name/
    sudo chmod +x start.sh
    echo "complete! Use ./start.sh to start up the server (uses 2 cores and 1GiB or ram)"
    else
    echo "install stopped"
    fi