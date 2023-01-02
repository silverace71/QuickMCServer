#!/bin/bash

echo "do you wish to run this setup tool (y/n)?"
read conf
    if [[ $conf == "y" ]]; then
    echo "what do you want to call your server?"
    read name
    sudo apt install nano -y
    sudo apt install apt-utils -y
    sudo apt install openjdk-17-jdk -y
    