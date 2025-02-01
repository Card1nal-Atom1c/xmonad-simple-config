Xmobar-Xmonad-SimpleConfig
--------------------------------------
Obiamente Tienes que tener
Xmonad y Xmobar,
Picom,
Nitrogen,
Conky,
Kitty(yo uso la config de s4vitar)...
Basicamente copia el repo y dale permisos de ejecucion a los archivos con chmod +x para que se puedan ejecutar los scripts de bash en especial a (xmonad.hs, xmobarrc, picom.conf y conky.conf) si no puede dar problemas
![image](https://github.com/user-attachments/assets/e243351a-5bbd-4c6e-8f54-79716fd92e2d)
![imagen_2025-02-01_115721599](https://github.com/user-attachments/assets/085926e8-bd28-4f7a-b807-8fbe03c41e43)
'''haskell//
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
 '''
