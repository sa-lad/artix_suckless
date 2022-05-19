#!/bin/sh
# ARTIX LINUX
# Setup script for my config of suckless tools/ dwm.

# Dependencies/ must haves.
packages="
base-devel
xorg-server
xorg-xinit
xorg-xrandr
libx11
libxinerama
libxft
webkit2gtk
feh
terminus-font
tff-hanazono
"
sudo pacman -Syu $packages

plsaudio="
pulseaudio
pavucontrol
"
echo && read -p "> install pulseaudio? [Y/n] " inst_pls

if [[ $inst_pls == "Y" || $inst_pls == "y" ]]; then
    sudo pacman -Syu $plsaudio
fi

# Directory for building.
directory=~/.local/src
mkdir ~/.local
mkdir $directory

# Remove/ copy files and then build.
sudo rm ~/.bashrc
sudo rm ~/.bash_profile
sudo rm ~/.xinitrc
sudo rm ~/.Xresources

curdir=$(pwd)
cp -r $curdir/src/dwm $directory
cp -r $curdir/src/dmenu $directory
cp -r $curdir/src/st $directory
cp -r $curdir/src/slstatus $directory
cp -r $curdir/src/scroll $directory
cp $curdir/resources/bash/bashrc ~/.bashrc
cp $curdir/resources/bash/bash_profile ~/.bash_profile
cp $curdir/resources/xorg/xinitrc ~/.xinitrc
cp $curdir/resources/xorg/Xresources ~/.Xresources

cd $directory/dwm && sudo make clean install
cd $directory/dmenu && sudo make clean install
cd $directory/st && sudo make clean install
cd $directory/slstatus && sudo make clean install

echo && read -p "> enable st scrollback? [Y/n] " stscroll

if [[ $stscroll == "Y" || $stscroll == "y" ]]; then
    cd $directory/scroll && sudo make clean install
fi

echo -e "\n> finished."
