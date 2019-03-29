#!/bin/bash

PORT="$1"
USER="dtg"
HOST="127.0.0.1"

scp -P "$PORT" -rp ./dotfiles/. $USER@$HOST:~/
# scp -P 2222 dtg@127.0.0.1:/usr/share/X11/xorg.conf.d ./xorg.conf.d

# sudo pacman -Rs xmonad xmonad-contrib xmobar
# sudo pacman -Syu xmonad xmonad-contrib
# sudo pacman -Syu fish
# sudo pacman -Syu xmobar

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


