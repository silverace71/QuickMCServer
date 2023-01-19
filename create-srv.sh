#!/bin/bash
echo "do you wish to run SilverServer setup (y/n)?"
read r0
if [[ $r0 =~ ^[Yy]$ ]]; then
    echo -e "Have you installed java yet (y/n)?"
    read r0
    if [[ $r0 =~ ^[Yy]$ ]]; then
    sleep 0
    else
    sudo apt install openjdk-17-jdk -y
    fi
    echo -e "What server will this be?"
    PS3="Choose an option:"
    select option in "1||Paper" "2||Fabric" "3||Forge" "4||Vanilla"; do
    case $option in
        "1||Paper")
        echo "You selected Option 1"
        exit
        break
        ;;
        "2||Fabric")
        echo "You selected Option 2"
        exit
        break
        ;;
        "3||Forge")
        echo "You selected Option 3"
        exit
        break
        ;;
        "4||Vanilla")
        echo "You selected Option 3"
        exit
        break
        ;;
        *)
        echo "Invalid selection"
        ;;
    esac
    done

else
echo "install cancelled"
exit
fi
echo "done!"
exit









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