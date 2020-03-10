#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Anaconda"
apt-get update 
apt-get install -y wget
wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh
bash Anaconda3-2019.03-Linux-x86_64.sh -b
apt-get clean -y
