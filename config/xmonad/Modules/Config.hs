module Modules.Config where

-- Custom Imports
import           Modules.Layouts

-- XMonad imports
import           XMonad.Config

myConfig = def
    { modMask = mod4Mask
    , terminal = "kitty"
    , manageHook = namedScratchpadManageHook scratchpads
    , layoutHook = myLayoutHook
    , borderWidth = 2
    , logHook = updatePointer (0.5, 0.5) (0, 0)
                <> toggleFadeInactiveLogHook 0.9
                <> workspaceHistoryHook
                <> setWorkspaceNames
                <> logHook def
    , handleEventHook = followIfNoMagicFocus
                        <> minimizeEventHook
                        -- <> restartEventHook
                        <> myScratchPadEventHook
    , startupHook = myStartup
    , keys = customKeys (const []) addKeys
    }
