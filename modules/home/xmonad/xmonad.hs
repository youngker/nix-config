module Main where

import Data.Char (toUpper)
import Data.Foldable
import qualified Data.Map as M
import Data.Maybe
import Data.Monoid
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.PhysicalScreens
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place
import XMonad.Layout.Grid
import XMonad.Layout.IndependentScreens
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.ResizableTile
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Layout.WorkspaceDir (changeDir)
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.Man
import XMonad.Prompt.Shell
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.FuzzyMatch (fuzzyMatch, fuzzySort)
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.WorkspaceCompare

myBrowserApp = "google-chrome-stable --no-sandbox"

myTerminalApp = "alacritty"

commandPrompt :: XPConfig -> String -> M.Map String (X ()) -> X ()
commandPrompt c p m =
  inputPromptWithCompl c p (mkComplFunFromList c (M.keys m))
    ?+ (\k -> fromMaybe (return ()) (M.lookup k m))

commands :: M.Map String (X ())
commands =
  M.fromList
    [ ("logout", io exitSuccess),
      ("lock", spawn "xscreensaver-command -lock"),
      ("suspend", spawn "xscreensaver-command -lock && sleep 2 && sudo systemctl suspend -i"),
      ("shutdown", spawn "sleep 2 && systemctl poweroff"),
      ("restart", spawn "sleep 2 && systemctl reboot"),
      ("sleep", spawn "xscreensaver-command -lock && sleep 1 && sudo pm-suspend")
    ]

_XPConfig :: XPConfig
_XPConfig =
  def
    { font = "xft:Lucida Grande:bold:size=20",
      autoComplete = Nothing,
      bgColor = "#1E2029",
      bgHLight = "#cc6666",
      borderColor = "#282a36",
      changeModeKey = xK_semicolon,
      completionKey = (0,xK_Tab),
      defaultPrompter = id $ map toUpper,
      defaultText = [],
      fgColor = "#bbc2cf",
      fgHLight = "#282a36",
      height = 80,
      historyFilter = deleteAllDuplicates,
      historySize = 256,
      maxComplRows = Just 10,
      position = CenteredAt 0.1 0.7,
      promptBorderWidth = 5,
      searchPredicate = fuzzyMatch,
      showCompletionOnTab = False,
      sorter = fuzzySort
    }

myPlacement = withGaps (0, 0, 0, 0) (smart (0.5, 0.5))

myManagementHooks =
  composeAll
    [ className =? "Mail" --> doShift "mail",
      className =? "Google-chrome" --> doShift "web",
      className =? "Firefox" --> doShift "web",
      className =? "clipboard-google-translate" --> doFloat,
      className =? "QjackCtl" --> doFloat,
      className =? "lmms" --> doFloat,
      className =? "Pavucontrol" --> doFloat,
      className =? "Carla2" --> doFloat,
      className =? "Ardour" --> doFloat
    ]

data Colors
  = NormalBorder
  | FocusedBorder
  | InActiveBackground
  | InActiveTabBackground
  | ActiveBackground
  | VisibleWorkspace
  | CurrentWorkspace
  | CurrentTitle
  deriving (Show)

color :: Colors -> String
color x = case x of
  NormalBorder -> "#2e3440"
  FocusedBorder -> "#2e3440"
  InActiveBackground -> "#2e3440"
  InActiveTabBackground -> "#2e3440"
  ActiveBackground -> "#5e81ac"
  VisibleWorkspace -> "#ebcb8b"
  CurrentWorkspace -> "#bf616a"
  CurrentTitle -> "#a3be8c"

titleConfig =
  def
    { inactiveBorderColor = color InActiveBackground,
      inactiveColor = color InActiveBackground,
      inactiveTextColor = color InActiveBackground,
      activeBorderColor = color ActiveBackground,
      activeColor = color ActiveBackground,
      activeTextColor = color ActiveBackground,
      decoHeight = 10
    }

confShowWName =
  def
    { swn_font = "xft:Lucida Grande:bold:size=100",
      swn_bgcolor = color InActiveBackground,
      swn_color = color ActiveBackground,
      swn_fade = 2
    }

startup =
  [ "bingwallpaper",
    "setxkbmap -option ctrl:nocaps"
  ]

data Workspace = WS
  { workspaceName :: String,
    workspaceAction :: X ()
  }

workspace =
  [ WS "code" $ spawn "alacritty",
    WS "web" $ spawn "google-chrome",
    WS "etc" $ spawn "alacritty",
    WS "mail" $ spawn "thunderbird",
    WS "vm" $ spawn "alacritty"
  ]

additionalKey :: [(String, X ())]
additionalKey =
  [ ("M-q", kill),
    ("M-<Space>", sendMessage NextLayout),
    ("M-<Tab>", windows W.focusDown),
    ("M-j", windows W.focusDown),
    ("M-S-j", windows W.swapDown),
    ("M-k", windows W.focusUp),
    ("M-S-k", windows W.swapUp),
    ("M-m", windows W.swapMaster),
    ("M-u", sendMessage (IncMasterN 1)),
    ("M-i", sendMessage (IncMasterN (-1))),
    ("M-h", sendMessage Shrink),
    ("M-l", sendMessage Expand),
    ("M-S-h", sendMessage MirrorShrink),
    ("M-S-l", sendMessage MirrorExpand),
    ("M-z", sendMessage $ Toggle FULL),
    ("M-t", withFocused $ windows . W.sink),
    ("M-C-<Return>", spawn "bingwallpaper"),
    ("M-S-<Return>", spawn myTerminalApp),
    ("M-S-b", spawn myBrowserApp),
    ("M-<Down>", spawn "pactl set-sink-volume 50 -5%"),
    ("M-<Up>", spawn "pactl set-sink-volume 50 +5%"),
    ("<F9>", spawn "xmonad --recompile"),
    ("<F10>", spawn "xmonad --recompile; xmonad --restart")
  ]

myComplexKeys :: [((KeyMask, KeySym), X ())]
myComplexKeys =
  [ ((mod1Mask, xK_F1), commandPrompt _XPConfig "command" commands),
    ((mod1Mask, xK_F2), changeDir _XPConfig),
    ((mod1Mask, xK_F3), shellPrompt _XPConfig),
    ((mod1Mask, xK_F4), manPrompt _XPConfig),
    ((mod1Mask, xK_Return), runOrRaisePrompt _XPConfig)
  ]

keyboard conf@XConfig {XMonad.modMask = modm} =
  M.fromList $
    [ ((m .|. modm, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9],
        (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]
      ++ [ ( (m .|. modm, key),
             screenWorkspace sc >>= flip whenJust (windows . f)
           )
           | (key, sc) <- zip [xK_bracketright, xK_bracketleft] [0 ..],
             (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
         ]

layout = tile ||| mtile ||| grid ||| tab
  where
    spc = spacingWithEdge 4
    tall = spc $ ResizableTall 1 (3 / 100) (1 / 2) []
    tile = deco tall
    mtile = deco $ Mirror tile
    grid = deco $ spc Grid
    tab = tabbed shrinkText titleConfig
    deco = noFrillsDeco shrinkText titleConfig

fadeLogHook = fadeWindowsLogHook fadeHook
  where
    fadeHook :: FadeHook
    fadeHook = opaque <+> (isUnfocused --> transparency 0.05) <+> (isFloating --> opaque)

myXmobar :: (Int, Handle) -> X ()
myXmobar (screenId, xmobarPipe) = do
  dynamicLogWithPP $
    xmobarPP
      { ppOutput = hPutStrLn xmobarPipe,
        ppLayout = const "",
        ppTitle = xmobarColor (color CurrentTitle) "",
        ppSep = "      |      ",
        ppWsSep = "  ",
        ppVisible = xmobarColor (color VisibleWorkspace) "",
        ppCurrent = xmobarColor (color CurrentWorkspace) ""
      }

xmobarCmd :: MonadIO m => Int -> Int -> m (Int, Handle)
xmobarCmd nScreens screen = do
  xmobarPipe <- spawnPipe cmd
  pure (screen, xmobarPipe)
  where
    cmd = "xmobar --screen=" <> show (succ nScreens - screen)

main :: IO ()
main = do
  nScreens <- countScreens
  xmobarPipes <- traverse (xmobarCmd nScreens) [1 .. nScreens]
  xmonad $
    docks
      def
        { terminal = myTerminalApp,
          manageHook = manageDocks <+> manageHook def <+> placeHook myPlacement <+> myManagementHooks,
          layoutHook = showWName' confShowWName $ mkToggle (single FULL) $ avoidStruts $ smartBorders layout,
          workspaces = map workspaceName workspace,
          startupHook = traverse_ spawn startup,
          logHook = fadeLogHook <+> traverse_ myXmobar xmobarPipes,
          keys = keyboard,
          normalBorderColor = color NormalBorder,
          focusedBorderColor = color FocusedBorder,
          modMask = mod1Mask,
          focusFollowsMouse = False
        }
      `additionalKeysP` additionalKey
      `additionalKeys` myComplexKeys
