module Modules.Keymaps where

import           XMonad.Util.EZConfig as EZ
import           XMonad.Util.Ungrab

alt = mod1

EZ.additionalKeysP
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-C-s", unGrab *> spawn "maim -s")
    ]
