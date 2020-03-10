#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

#wget -qO - https://www.mellanox.com/downloads/ofed/RPM-GPG-KEY-Mellanox | sudo apt-key add -
apt update -y
apt-get install mlnx-ofed-all -y

