#!/bin/bash
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
echo "Use ./start.sh to start the Proxy Server!"