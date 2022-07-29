module Modules.Colorscheme where

import           XMonad.Layout.Decoration.Theme

data Colorscheme = Colorscheme
    { color0  :: String
    , color1  :: String
    , color2  :: String
    , color3  :: String
    , color4  :: String
    , color5  :: String
    , color6  :: String
    , color7  :: String
    , color8  :: String
    , color9  :: String
    , color10 :: String
    } deriving (Eq)


catppuccin ∷ Colorscheme
catppuccin = def
    { color0 = "#d8dee9"
    , color1 = "#1e1e2e"
    , color2 = "#313244"
    , color3 = "#f5a97f"
    , color4 = "#f5c2e7"
    , color5 = "#f2cdcd"
    , color6 = "#eba0ac"
    , color7 = "#f2779c"
    , color8 = "#c9cbff"
    , color9 = "#b5e8e0"
    , color10 = "#b1e1a6"
    }

active = catppuccin

applyTheme ∷ Theme
applyTheme = def
    { activeColor = active
    , activeBorderColor = active
    , activeTextColor = inactive
    , decoHeight = 20
    , inactiveColor = inactive
    , inactiveBorderColor = inactive
    , inactiveTextColor = active
    , fontName = "xft:VictorMono Nerd Font:style=SemiBold"
    }
