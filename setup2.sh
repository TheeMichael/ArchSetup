#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR


echo "You want these packages when installing gnome"
echo "all packages"
echo "pipewire-jack"
echo "wireplumber"
echo "noto-fonts-emoji"
echo "Enter 2 2 1 1"

sudo pacman -Syu
sudo pacman -S gnome gnome-tweaks gnome-terminal git firefox neofetch jq htop steam discord grub-customizer
sudo systemctl enable gdm.service

mkdir $SCRIPT_DIR/Temp


# Get browser connector to install extensions from browser
cd $SCRIPT_DIR/Temp
git clone https://aur.archlinux.org/gnome-browser-connector.git
cd gnome-browser-connector
makepkg -si
$SCRIPT_DIR/Temp
rm -rf ./gnome-browser-connector

# Get humanity icon theme which is prereq for yaru theme
cd $SCRIPT_DIR/Temp
git clone https://aur.archlinux.org/humanity-icon-theme.git
cd humanity-icon-theme
makepkg -si
$SCRIPT_DIR/Temp
rm -rf ./humanity-icon-theme


# get yaru theme
cd $SCRIPT_DIR/Temp
git clone https://aur.archlinux.org/yaru.git
cd yaru
makepkg -si
$SCRIPT_DIR/Temp
rm -rf ./yaru


# get terminal transparency
cd $SCRIPT_DIR/Temp
git clone https://aur.archlinux.org/gnome-terminal-transparency.git
cd gnome-terminal-transparency
makepkg -si
$SCRIPT_DIR/Temp



#Wallpapers
mkdir ~/Pictures/Wallpapers
cp $SCRIPT_DIR/Wallpapers/* ~/Pictures/Wallpapers

#Dot files
cp -R $SCRIPT_DIR/dotfiles/. ~/


#Enable user theme extension and removable drive menu
#gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
#gnome-extensions enable drive-menu@gnome-shell-extensions.gcampax.github.com


# Disables speech auto spawn which causes audio glitches
s1='# DisableAutoSpawn'
s2='DisableAutoSpawn'
sudo sed -i "s|$s1|$s2|g" /etc/speech-dispatcher/speechd.conf


# Install new grub theme
mkdir ~/Documents/GrubThemes
cd ~/Documents/GrubThemes
git clone https://github.com/ChrisTitusTech/Top-5-Bootloader-Themes
cd Top-5-Bootloader-Themes/
sudo ./install.sh


# Load all dconf settings
cat $SCRIPT_DIR/conf/all.preferences | dconf load /

sudo reboot