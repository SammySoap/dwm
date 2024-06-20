#!/bin/bash

DWM_VERSION="6.5"
DMENU_VERSION="5.3"

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

prompt() {
    while true; do
        read -p "$1 (y/N): " option
        case $option in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) return 1;;
        esac
    done
}

echo -e "${GREEN}Beginning of script${NC}"

sudo apt update && sudo apt install make gcc libx11-dev libxft-dev libxinerama-dev xorg

wget -O dwm.tar.gz "https://dl.suckless.org/dwm/dwm-${DWM_VERSION}.tar.gz"
wget -O dmenu.tar.gz "https://dl.suckless.org/tools/dmenu-${DMENU_VERSION}.tar.gz"

tar -xf dwm.tar.gz
tar -xf dmenu.tar.gz

cd "./dwm-${DWM_VERSION}"
TERMINAL="static const char *termcmd[]  = { \"xterm\", NULL };"
sed -i "61s/.*/${TERMINAL}/" "config.h"
sudo make clean install

cd "../dmenu-${DMENU_VERSION}"
sudo make clean install

cd ../

wget https://raw.githubusercontent.com/SammySoap/dwm/master/.xinitrc
wget https://raw.githubusercontent.com/SammySoap/dwm/master/.Xresources

if prompt "Do you want to install waterfox?"; then
    wget -O waterfox.tar.bz2 "https://cdn1.waterfox.net/waterfox/releases/G6.0.16/Linux_x86_64/waterfox-G6.0.16.tar.bz2"
    tar -xf waterfox.tar.bz2
    sudo mv ./waterfox /opt/
    sudo apt install libgtk-3-dev libasound2-dev libdbus-glib-1-2
    sudo ln -s /opt/waterfox/waterfox /usr/bin/
fi

echo -e "\n\n\n\n${GREEN}Done, 'startx' to start dwm${NC}"