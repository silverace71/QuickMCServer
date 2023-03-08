#!/bin/bash
pwd=$(pwd)
w=bad
echo "Dont worry about the broken pipe error, it still works lol"
sleep 1
while [[ $w == bad ]]; do
    echo "what version of minecraft do you want?"
    read ver
  html=$(curl -s https://files.minecraftforge.net/net/minecraftforge/forge/index_"$ver".html)
  link=$(echo "$html" | grep -o 'https://.*installer.jar' | sed 's/\.jar/\.jar\n/' | head -n 1 | sed 's/^.*https:\/\/maven/https:\/\/maven/')
  sleep 1
  install=forge-"$ver"${link#*/forge-"$ver"}
  sleep 1
  echo "$install"
  if [[ "$install" == *installer.jar ]]; then
      w=clear
  else
      w=bad
      echo "That is not a valid version that forge supports, please choose a different option."
      sleep 1
  fi
done
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
if echo "$ver" | grep -qE '[0-9]+'
then
    if echo "$ver" | grep -qE '(^|[^0-9])[1-9][7-9]|[2-9][0-9]+([^0-9]|$)'
    then
    wget $link
  mv $install forge.jar
  java -jar forge.jar --installServer
  wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/eula.txt
cat << EOF >> user_jvm_args.txt
-Xms128M -Xmx"$ram"M -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+ParallelRefProcEnabled -XX:ParallelGCThreads=$cc -XX:ConcGCThreads=$cc -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:+UseCompressedOops -XX:+UseVectorCmov -XX:+UseStringDeduplication -XX:+AllowParallelDefineClass -XX:-DontCompileHugeMethods
EOF
        fc2=run.sh
        ts5="unix_args.txt"
        tc5="unix_args.txt nogui"
        sed -i "s/$ts5/$tc5/g" $fc2
echo "generating files. This may take a bit depending on your systems specs!"
pwd=$(pwd)
nohup ./run.sh &

while [ ! -f "$pwd/ops.json" ]; do
  sleep 1
done
echo "done generating all files"
sleep 4
server_pid=$(pgrep -f user_jvm_args.txt)
sleep 1
kill $server_pid
    fi
sleep 0
else
    echo "Somehow, you messed this up."
fi
if echo "$ver" | grep -qE '[0-9]+'
then
    if echo "$ver" | grep -qE '(^|[^0-9])[1-9][7-9]|[2-9][0-9]+([^0-9]|$)'
    then
        echo "Use run.sh to start your server!"
    else
  wget $link
  mv $install forge.jar
  java -jar forge.jar --installServer
  wget https://raw.githubusercontent.com/silverace71/QuickMCServer/main/eula.txt

cat << EOF >> run.sh
java -jar -Xms128M -Xmx"$ram"M -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+ParallelRefProcEnabled -XX:ParallelGCThreads=$cc -XX:ConcGCThreads=$cc -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:MaxTenuringThreshold=1 -XX:+UseCompressedOops -XX:+UseVectorCmov -XX:+UseStringDeduplication -XX:+AllowParallelDefineClass -XX:-DontCompileHugeMethods minecraft_server."$ver".jar nogui
EOF
echo "generating files. This may take a bit depending on your systems specs!"
sudo chmod +x run.sh
pwd=$(pwd)
nohup ./run.sh &

while [ ! -f "$pwd/ops.json" ]; do
  sleep 1
done
echo "done generating all files"
sleep 4
server_pid=$(pgrep -f minecraft_server."$ver".jar)
sleep 1
kill $server_pid
    fi
else
    echo "Somehow, you messed this up."
fi
        fc1=server.properties
        ts0=simulation-distance=10
        tc0=simulation-distance="$vdist"
        ts1=max-tick-time=60000
        tc1="max-tick-time=-1"
        ts2=view-distance=10
        tc2=view-distance="$vdist"
        ts3=server-port=25565
        tc3=server-port="$port"
        sed -i "s/$ts0/$tc0/g" $fc1
        sed -i "s/$ts1/$tc1/g" $fc1
        sed -i "s/$ts2/$tc2/g" $fc1
        sed -i "s/$ts3/$tc3/g" $fc1
echo "server is now ready for use!"