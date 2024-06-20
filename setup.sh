#!/bin/bash

DWM_VERSION="6.5"
DMENU_VERSION="5.3"

apt update

wget "https://dl.suckless.org/dwm/dwm-${DWM_VERSION}.tar.gz"
wget "https://dl.suckless.org/tools/dmenu-${DMENU_VERSION}.tar.gz"

tar -xf dwm-${DWM_VERSION}.tar.gz
tar -xf dmenu-${DMENU_VERSION}.tar.gz