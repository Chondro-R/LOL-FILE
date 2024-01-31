#!/bin/bash
Y='\033[0;33m'
G='\033[0;32m'
RESET='\033[0m'
R='\033[0;31m'
sleep 0.4
apt install qpdf
apt install unrar
apt install p7zip-full
apt install p7zip
7z x "LOL-FILE.zip" &>/dev/null
rm -rf LOL-FILE.zip
echo -e "${G}Now run LOL-FILE.sh ${RESET}"
rm -rf install.sh