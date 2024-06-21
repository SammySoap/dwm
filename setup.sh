#!/bin/bash

#github branch (main/dev)
DEVELOPMENT_BRANCH="dev"

DWM_VERSION="6.5"
DMENU_VERSION="5.3"

TERMINAL="static const char *termcmd[]  = { \"xterm\", NULL };"

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

prompt() {
    while true; do
        read -p "${YELLOW}$1 [y/n]:${NC} " option
        case $option in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes (y) or no (n).";;
        esac
    done
}

echo -e "${GREEN}Beginning of script${NC}"

cd $HOME

#installs dwm dependencies
packages="make gcc libx11-dev libxft-dev libxinerama-dev xorg"
sudo apt update && sudo apt install $packages

#prompt to set dark mode in the configuration file
if prompt "Do you want to set dark mode as default theme?"; then
    
    mkdir ./.config/gtk-3.0
    cat <<EOL > "./.config/gtk-3.0/settings.ini"
    [Settings]
    gtk-application-prefer-dark-theme=1
EOL
    
fi

#download dwm and dmenu from the suckless website
wget -O dwm.tar.gz "https://dl.suckless.org/dwm/dwm-${DWM_VERSION}.tar.gz"
wget -O dmenu.tar.gz "https://dl.suckless.org/tools/dmenu-${DMENU_VERSION}.tar.gz"

tar -xf dwm.tar.gz
tar -xf dmenu.tar.gz

cd "./dwm-${DWM_VERSION}"

sed -i "61s/.*/${TERMINAL}/" "config.def.h"
sudo make clean install

cd "../dmenu-${DMENU_VERSION}"
sudo make clean install

cd ../

#download configuration files for X server and xterm
wget "https://raw.githubusercontent.com/SammySoap/dwm/${DEVELOPMENT_BRANCH}/.xinitrc"
wget "https://raw.githubusercontent.com/SammySoap/dwm/${DEVELOPMENT_BRANCH}/.Xresources"


#prompt to install the browser waterfox (firefox fork)
if prompt "Do you want to install waterfox?"; then
    
    #waterfox dependencies
    sudo apt install libgtk-3-dev libasound2-dev libdbus-glib-1-2
    
    #install waterfox
    wget -O waterfox.tar.bz2 "https://cdn1.waterfox.net/waterfox/releases/G6.0.16/Linux_x86_64/waterfox-G6.0.16.tar.bz2"
    sudo tar -xf waterfox.tar.bz2 -C /opt
    sudo ln -s /opt/waterfox/waterfox /usr/bin/
    
fi


echo -e "\n\n\n\n${GREEN}Done, 'startx' to start dwm${NC}"