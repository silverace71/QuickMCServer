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
        wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/paper-server.sh
        sudo chmod +x paper-server.sh
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
        "5||Bungeecord Proxy")
        wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/bungee-proxy.sh
        sudo chmod +x bungee-proxy.sh
        ./bungee-proxy.sh
        sleep 0
        exit
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