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
"
sudo pacman -Syu $packages

audio="
pipewire
pipewire-pulse
pipewire-media-session
pavucontrol
"
echo; read -p ":: install pipewire audio? [Y/n] " inst_pipe

if [[ $inst_pipe == "Y" || $inst_pipe == "y" || $inst_pipe == "" ]]; then
    sudo pacman -Syu $audio
fi

# Directory for building.
directory=~/.local/src
mkdir -p $directory

# Remove/ copy files and then build.
sudo rm ~/.bashrc
sudo rm ~/.bash_profile
sudo rm ~/.xinitrc
sudo rm ~/.Xresources

curdir=$(pwd)
sudo cp -r $curdir/src/* $directory
sudo cp -r $curdir/resources/font/* /usr/share/fonts/
cp -r $curdir/resources/gtk-3.0 ~/.config
cp $curdir/resources/bash/bashrc ~/.bashrc
cp $curdir/resources/bash/bash_profile ~/.bash_profile
cp $curdir/resources/xorg/xinitrc ~/.xinitrc
cp $curdir/resources/xorg/Xresources ~/.Xresources

cd $directory/dwm && sudo make clean install
cd $directory/dmenu && sudo make clean install
cd $directory/st && sudo make clean install
cd $directory/slstatus && sudo make clean install

echo; read -p ":: enable st scrollback? [Y/n] " stscroll

if [[ $stscroll == "Y" || $stscroll == "y" || $stscroll == "" ]]; then
     cd $directory/scroll && sudo make clean install
fi

echo -e "\n:: finished!"
