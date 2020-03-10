#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Vscode"
apt-get update 
apt install -y libxss1
wget https://az764295.vo.msecnd.net/stable/51b0b28134d51361cf996d2f0a1c698247aeabd8/code_1.33.1-1554971066_amd64.deb
apt install -y  ./code_1.33.1-1554971066_amd64.deb
apt-get clean -y
