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
    name=paper
    api=https://api.papermc.io/v2
    latest_build="$(curl -sX GET $api/projects/$name/versions/$version/builds -H 'accept: application/json' | jq '.builds [-1].build')"
    download_url=""$api"/projects/"$name"/versions/"$version"/builds/"$latest_build"/downloads/"$name"-"$version"-"$latest_build".jar"
    wget $download_url
    wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/eula.txt
    mv "$name"-"$version"-"$latest_build".jar paper.jar
cat << EOF >> start.sh
#!/bin/bash
java -jar -Xms128M -Xmx"$ram"M -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+ParallelRefProcEnabled -XX:ParallelGCThreads=$cc -XX:ConcGCThreads=$cc -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:+UseCompressedOops -XX:+UseVectorCmov -XX:+UseStringDeduplication -XX:+AllowParallelDefineClass -XX:-DontCompileHugeMethods paper.jar nogui
EOF
sudo chmod +x start.sh
echo "generating files. This may take a bit depending on your systems specs!"
nohup ./start.sh &

while [ ! -d "$pwd/world_the_end" ]; do
  sleep 1
done
echo "done generating all files"
sleep 4
server_pid=`pgrep -f paper.jar`
kill $server_pid

    echo -e "Please choose what kind of paper server this will be?"
    PS3="Choose an option:"
    select option in "1||Standalone" "2||Bungeecord"; do
    case $option in
        "1||Standalone")
        echo "Setting up standalone paper server"
        sleep 0
        break
        ;;
        "2||Bungeecord")
        echo "Setting up paper server as part of a network"
## shitpost time

        fc1=server.properties
        ts0=simulation-distance=10
        tc0=simulation-distance="$vdist"
        ts1=max-tick-time=60000
        tc1="max-tick-time=-1"
        ts2=view-distance=10
        tc2=view-distance="$vdist"
        ts3=server-port=25565
        tc3=server-port="$port"
        ts4=online-mode=true
        tc4="online-mode=false"
        fc2=bukkit.yml
        ts5="connection-throttle: 4000"
        tc5="connection-throttle: -1"
        fc3=spigot.yml
        ts6="bungeecord: false"
        tc6="bungeecord: true"
        sed -i "s/$ts0/$tc0/g" $fc1
        sed -i "s/$ts1/$tc1/g" $fc1
        sed -i "s/$ts2/$tc2/g" $fc1
        sed -i "s/$ts3/$tc3/g" $fc1
        sed -i "s/$ts4/$tc4/g" $fc1
        sed -i "s/$ts5/$tc5/g" $fc2
        sed -i "s/$ts6/$tc6/g" $fc3
        sleep 0
        break
        ;;
        *)
        echo "Invalid selection"
        ;;
    esac
  done
sleep 0
else
    echo "fortnite battle pass. Anyways canceled installation"
    exit
fi
echo "balls"