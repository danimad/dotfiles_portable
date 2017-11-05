import System.IO
import System.Exit
import Control.Monad
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (ToggleStruts(..),docks,avoidStruts,manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal = "uxterm"

-- some parts from: https://www.nepherte.be/blog/step-by-step-configuration-of-xmonad.html
myWorkspaces = ["1:main", "2:spacemacs", "3:ranger"]

myLayout = avoidStruts ( smartBorders (
    -- ThreeColMid 1 (3/100) (1/2) |||
    -- Tall 1 (3/100) (1/2) |||
    -- Mirror (Tall 1 (3/100) (1/2)) |||
    Full |||
    -- Tall |||
    spiral (6/7))) |||
    noBorders (fullscreenFull Full)

myManageHook = composeAll . concat $
    [
      [ className =? "stalonetray" --> doIgnore ]
     ,[ className =? b --> viewShift "2:spacemacs" | b <- myClassEmacsShifts ]
     -- puts the application on the workspace in the background:
     --,[ resource  =? c --> doF (W.shift "chat") | c <- myClassChatShifts ]
    ]
    where
      viewShift = doF . liftM2 (.) W.greedyView W.shift
      myClassEmacsShifts = ["Emacs"]
      -- myClassChatShifts = ["Pidgin"]

xmobarCurrentWorkspaceColor = "#CEFFAC"

mykeys (XConfig {XMonad.modMask = modm}) = M.fromList $
        [
        --  ((modm, xK_b), sendMessage ToggleStruts)
        -- ,((modm, xK_u), spawn "ulauncher")
        ]

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/danielb/.xmobarrc"
    xmonad $ docks defaultConfig
        { terminal    = "uxterm"
        , manageHook = manageDocks <+> myManageHook
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , workspaces = myWorkspaces
        -- , layoutHook = myLayout
        , logHook = dynamicLogWithPP xmobarPP
                          { ppOutput = hPutStrLn xmproc
                          , ppTitle  = xmobarColor "green" "" . shorten 50
                          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                          , ppSep = " "
                          }
        -- , modMask     = mod4Mask
        -- , borderWidth = 3
        , keys = \c -> mykeys c `M.union` keys defaultConfig c
        }-- `additionalKeys` toggleStrutsKey
        -- [ ((modMask, xK_b), sendMessage ToggleStruts)
        -- ]
