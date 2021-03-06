#!/bin/bash

# Install required depencies
sudo pacman -Syu --noconfirm xmonad xmonad-contrib xorg-server xorg-xinit rxvt-unicode

# Create xmonad files to start session
echo 'xmonad' > ~/.xinitrc
echo 'xmonad' > ~/.xsession

# Create XMonad configuration file
mkdir ~/.xmonad
echo 'import XMonad
 
main = xmonad def
    { terminal    = "urxvt"
    }' > ~/.xmonad/xmonad.hs

xmonad --recompile

# Create Xresource file
echo '!do not scroll'
xrdb ~/.Xresources