Xmobar-Xmonad-SimpleConfig
--------------------------------------
Obiamente Tienes que tener
- Xmonad y Xmobar,
- Picom,
- Nitrogen,
- Conky,
- Kitty(yo uso la config de s4vitar)...
- la fuente HackNerdFont(o otra fuenta a eleccion lo unico que tendras que modificar la fuente en conky.conf y en el xmobarrc)
* Basicamente copia el repo y dale permisos de ejecucion a los archivos con chmod +x para que se puedan ejecutar los scripts de bash en especial a (xmonad.hs, xmobarrc, picom.conf y conky.conf) si no puede dar problemas
![image](https://github.com/user-attachments/assets/e243351a-5bbd-4c6e-8f54-79716fd92e2d)
![imagen_2025-02-01_115721599](https://github.com/user-attachments/assets/085926e8-bd28-4f7a-b807-8fbe03c41e43)
* vas a tener que modificar el xmobarrc cambiando "tu Usuario" por tu usuario de login(obiamente)
```haskell//
Config { font = "HackNerdFont 12"
        , borderColor = "black"
        , border = BottomB
        , alpha= 200
        , bgColor = "black"
        , fgColor = "white"
        , position = Static { xpos = 0 , ypos = 0, width = 1920, height = 25 }
        , commands = [    Run Date "%H:%M:%S" "date" 10
                        , Run StdinReader
                        , Run Com "/home/"tu Usuario"/.xmonad/IP.sh" [] "IP" 10
                        , Run Com "/home/"tu Usuario"/.xmonad/HTB.sh" [] "HTB" 10
                        , Run Com "/home/"tu Usuario"/.xmonad/SetTarget.sh" [] "SetTarget" 10
                        ]
        , sepChar = "%"
        , alignSep = "}{"
        , template = "[%StdinReader%]}{[%SetTarget%][%HTB%][%IP%][%date%] "
        --, template = "%StdinReader% }{ %date% "
        }
```
* puedes modificar los colores de el wrap y bordes de la xmobar desde el xmonad.hs
```haskell//
import System.IO
import System.Exit

import XMonad
import XMonad.Actions.WorkspaceNames
import XMonad.Actions.Navigation2D
import XMonad.Actions.UpdatePointer

import Data.Monoid

import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Cursor

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import qualified Data.Dynamic as XMonad.Hooks

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), spawn "dmenu_run")
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)  
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

myLayout = spacing 15 $ gaps[(U,17)] tiled ||| Mirror tiled ||| Full
  where
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

--Colors
--focusedBorderColor = "#ff94a4"
--xmobarCurrentWorkSpaceColor="#92f2fc"

--si quieres usar conky solo quita el -- de la linea 81 para que nope ste comentado

main = do
    xmproc0 <-spawnPipe "/usr/bin/xmobar -x 0 ~/.xmonad/xmobarrc"
    --xmproc1 <-spawnPipe "conky &"
    xmonad $ def{
        modMask=mod1Mask,
        borderWidth=3,
        normalBorderColor="#0000000",
        focusedBorderColor = "#ff94a4",
        terminal="kitty",
        keys=myKeys,
        mouseBindings=myMouseBindings,
        startupHook=do
            spawnOnce   "nitrogen --restore &"
            spawnOnce   "picom --config ~/.config/picom/picom.conf &"
       ,workspaces= ["1:Term", "2:Web", "3:Code","4:Media" ] ++ map show [5..8] ++ ["VPN"],
        manageHook= composeAll
                    [ resource  =? "desktop_window" --> doIgnore
                    , resource  =? "kdesktop"       --> doIgnore 
                    , resource  =? "Conky"          --> doIgnore],
        layoutHook= myLayout,
        logHook= dynamicLogWithPP xmobarPP
        {
            ppOutput= hPutStrLn xmproc0,
            ppTitle=XMonad.Hooks.DynamicLog.xmobarColor "#ff94a4" "".shorten 50,
            ppSep= " ",
            ppCurrent = XMonad.Hooks.DynamicLog.xmobarColor "#92f2fc" "".wrap "[" "]"
        }
    }

```
