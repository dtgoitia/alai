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
