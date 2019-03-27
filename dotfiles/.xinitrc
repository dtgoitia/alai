# [[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Load X configuration files
xrdb ~/.Xresources

# Start xmonad
#exec monad
xmonad