#!/bin/bash

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
echo "Please enter how many players you want on your server (20|40|100|1000|any numeric value)"
read maxplayer
pwd=$(pwd)
name1=waterfall
api=https://api.papermc.io/v2
latest_build_version="$(curl -sX GET https://api.papermc.io/v2/projects/waterfall -H 'accept: application/json' | jq '.versions [-1]')"
bv=$(echo "$latest_build_version" | sed -e 's/^"//' -e 's/"$//')
latest_build1="$(curl -sX GET https://api.papermc.io/v2/projects/waterfall/versions/"$bv"/builds -H 'accept: application/json' | jq '.builds [-1].build')"
download_url1=""$api"/projects/"$name1"/versions/"$bv"/builds/"$latest_build1"/downloads/"$name1"-"$bv"-"$latest_build1".jar"
wget $download_url1
mv "$name1"-"$bv"-"$latest_build1".jar waterfall.jar
cat << EOF >> start.sh
#!/bin/bash
java -Xms512M -Xmx512M -XX:+UseG1GC -XX:G1HeapRegionSize=4M -XX:+UnlockExperimentalVMOptions -XX:+ParallelRefProcEnabled -XX:+AlwaysPreTouch -jar waterfall.jar
EOF
sudo chmod +x start.sh
nohup ./start.sh &
while [ ! -d "$pwd/logs" ]; do
  sleep 0
done
echo "done generating all files"
sleep 3
server_pid=`pgrep -f waterfall.jar`
kill $server_pid
fc1=config.yml
ts0="player_limit: -1"
tc0="player_limit: "$maxplayer""
ts1="forge_support: true"
tc1="forge_support: false"
ts2="ip_forward: false"
tc2="ip_forward: true"
sed -i "s/$ts0/$tc0/g" $fc1
sed -i "s/$ts1/$tc1/g" $fc1
sed -i "s/$ts2/$tc2/g" $fc1
echo "Use ./start.sh to start the Proxy Server!"
rm nohup.out