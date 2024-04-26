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
    pwd=$(pwd)
    temp=$(curl -sX GET https://meta.fabricmc.net/v2/versions/loader/$ver/ -H 'accept: application/json' | jq '.[0].loader .version')
    loader_ver=$(echo "$temp" | tr -d '"')
    install_ver=$(curl -s https://maven.fabricmc.net/net/fabricmc/fabric-installer/ | grep -oP '\b\d{1,3}\.\d{1,3}\.\d{1,3}\b' | sort -r -V | head -1)
    download_url="https://meta.fabricmc.net/v2/versions/loader/"$ver"/"$loader_ver"/"$install_ver"/server/jar"
    curl -OJ $download_url
    wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/eula.txt
    mv fabric-server-mc."$ver"-loader."$loader_ver"-launcher."$install_ver".jar fabric.jar
cat << EOF >> start.sh
#!/bin/bash
java -jar -Xms128M -Xmx"$ram"M -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+ParallelRefProcEnabled -XX:ParallelGCThreads=$cc -XX:ConcGCThreads=$cc -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:+UseCompressedOops -XX:+UseVectorCmov -XX:+UseStringDeduplication -XX:+AllowParallelDefineClass -XX:-DontCompileHugeMethods fabric.jar nogui
EOF
sudo chmod +x start.sh
echo "Adding mods folder. "
mkdir mods
echo "add your mods in the mods folder and start the server with ./start.sh"
else
sleep 0
fi