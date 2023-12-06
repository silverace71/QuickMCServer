#!/bin/bash

echo "what version of minecraft do you want (MC Version 1.14+)?"
    read ver

    installer=$(curl -s https://maven.fabricmc.net/net/fabricmc/fabric-installer/ | grep -oP '\b\d{1,3}\.\d{1,3}\.\d{1,3}\b' | sort -r -V | head -1)
    loader=$(curl --silent "https://api.github.com/repos/FabricMC/fabric-loader/releases/latest" | grep -Po "(?<=\"tag_name\": \").*(?=\")")
    download="https://meta.fabricmc.net/v2/versions/loader/"$ver"/"$loader"/"$installer"/server/jar"
    echo "ver is $installer"
    echo "loader is $loader"
    echo "download link is $download"