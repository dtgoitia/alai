import XMonad
import XMonad.Hooks.DynamicLog

main = xmonad =<< xmobar defaultConfig
{   modMask = mod4Mask
    { terminal = "urxvt"
    }
}
