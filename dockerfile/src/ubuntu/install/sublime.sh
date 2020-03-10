#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install subl"
apt-get update 
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg |  apt-key add -
add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
apt update
apt install -y sublime-text
