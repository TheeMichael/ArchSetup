#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "You want these packages when installing gnome"
echo "all packages"
echo "pipewire-jack"
echo "wireplumber"
echo "noto-fonts-emoji"
echo "Enter 2 2 1"

sudo pacman -Syu
sudo pacman -S gnome gnome-tweaks gnome-terminal git firefox
sudo systemctl enable gdm.service

mkdir $SCRIPT_DIR/Temp


# Get browser connector
cd $SCRIPT_DIR/Temp
git clone https://aur.archlinux.org/gnome-browser-connector.git
cd gnome-browser-connector
makepkg -si


# Get humanity icon theme which is prereq for yaru theme
cd $SCRIPT_DIR/Temp
git clone https://aur.archlinux.org/humanity-icon-theme.git
cd humanity-icon-theme
makepkg -si


# get yaru theme
cd $SCRIPT_DIR/Temp
git clone https://aur.archlinux.org/yaru.git
cd yaru
makepkg -si


# get terminal transparency
cd $SCRIPT_DIR/Temp
git clone https://aur.archlinux.org/gnome-terminal-transparency.git
cd gnome-terminal-transparency
makepkg -si


cd ~/Temp
rm -rf ./gnome-browser-connector
rm -rf ./humanity-icon-theme
rm -rf ./yaru
rm -rf ./gnome-terminal-transparency


#Wallpapers
cp $SCRIPT_DIR/Wallpapers/* ~/Pictures/Wallpapers

#Dot files
cp $SCRIPT_DIR/dotfiles/* ~/

#Workspace switching hotkeys
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Shift><Alt>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Shift><Alt>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Shift><Alt>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Shift><Alt>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Shift><Alt>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Shift><Alt>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Shift><Alt>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Shift><Alt>8']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9 "['<Shift><Alt>9']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Alt>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Alt>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Alt>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Alt>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Alt>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Alt>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Alt>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Alt>8']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 "['<Alt>9']"

# Close window and app menu hotkeys
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>q']"
gsettings set org.gnome.shell.keybindings toggle-application-view "['<Alt>d']"

# Launch terminal hotkey
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Launch Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Alt>Return'


# Get min and max buttons for each window
gsettings set org.gnome.desktop.wm.preferences button-layout "close,minimize,maximize:"
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# Center new windows
gsettings set org.gnome.mutter center-new-windows true


#Change theme to Yaru
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru'
gsettings set org.gnome.desktop.interface icon-theme 'Yaru'
gsettings set org.gnome.desktop.sound theme-name 'Yaru'
gsettings set org.gnome.shell.extensions.user-theme name 'Yaru'


# Change clock format
org.gnome.desktop.interface clock-format '12h'
org.gtk.Settings.FileChooser clock-format '12h'



#Update terminal preferences
cat $SCRIPT_DIR/conf/gterminal.preferences | dconf load /org/gnome/terminal/legacy/profiles:/

#Enable user theme extension and removable drive menu
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable drive-menu@gnome-shell-extensions.gcampax.github.com



sudo reboot