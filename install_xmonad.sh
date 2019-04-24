#!/bin/bash

PORT="$1"
USER="dtg"
HOST="127.0.0.1"

scp -P "$PORT" -rp ./dotfiles/.* $USER@$HOST:~/
# scp -P 2222 dtg@127.0.0.1:/usr/share/X11/xorg.conf.d ./xorg.conf.d

sudo pacman -Syu fish

# Install `xorg` group packages and drivers (note: drivers might vary, check Wiki Xserver)
sudo pacman -Syu xorg xorg-xinit xf86-video-intel
sudo pacman -Syu xmonad xmonad-contrib rxvt-unicode xmobar ttf-bitstream-vera

# Install Git
# sudo pacman -Syu git

# Install utilities like pactree
# sudo pacman -Syu pacman-contrib

# Install yay
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si
# yay -Syu yay-bin
# Overwrite the existing git installation with yay-managed yay installation

# Install dmenu
# yay -Syu dmenu2

# Install nnn explorer
# yay -Syu nnn

# Install atop
# yay -Syu atop


