#!/bin/bash
echo "do you wish to run SilverServer setup (y/n)?"
read r0
if [[ $r0 =~ ^[Yy]$ ]]; then
    if echo "$git -v" | grep -q "^$version"; then
    sleep 0
    else
    sudo apt install git -y
    fi
    if echo "$java -version" | grep -q "^$version"; then
    sleep 0
    else
    sudo apt install openjdk-17-jdk -y
    fi
    if echo "$jq --help" | grep -q "^$manpage"; then
    sleep 0
    else
    sudo apt install jq -y
    fi
    echo -e "What server will this be?"
    PS3="Choose an option:"
    select option in "1||Paper" "2||Fabric" "3||Forge" "4||Bungee-Proxy"; do
    case $option in
        "1||Paper")
        wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/paper-server.sh
        sudo chmod +x paper-server.sh
        ./paper-server.sh
        break
        ;;
        "2||Fabric")
        wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/fabric-server.sh
        sudo chmod +x fabric-server.sh
        ./fabric-server.sh
        break
        ;;
        "3||Forge")
        wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/forge-server.sh
        sudo chmod +x forge-server.sh
        ./forge-server.sh
        break
        ;;
        "4||Bungee-Proxy")
        wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/bungee-proxy.sh
        sudo chmod +x bungee-proxy.sh
        ./bungee-proxy.sh
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
