import XMonad
import XMonad.Util.Run(spawnPipe)

-- `def` is a "default" configuration, of `XConfig` type. You create a
-- new copy of `def` with the curly brackets. The new copy will be
-- updated with the settings specified between the curly brackets.
myConfig = def
    { terminal = "urxvt"
    , workspaces = myWorkspaces
    }


------------------------------------------------------------------------
-- Workspaces
myWorkspaces = ["1", "2"]

------------------------------------------------------------------------
-- Run xmonad with all the defaults set up above
main = do
  xmproc <- spawnPipe "xmobar"
  
  xmonad $ myConfig
