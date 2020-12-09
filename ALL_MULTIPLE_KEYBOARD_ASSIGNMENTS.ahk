SetWorkingDir, C:\Users\Owner\source\repos\2nd-keyboard\support_files
;the above will set A_WorkingDir. It must be done in the autoexecute area.
;SetNumLockState, on ;This doesn't work, needs to be done in admin mode.
;SetScrollLockState, off
Menu, Tray, Icon, shell32.dll, 283 ;tray icon is now a little keyboard, or piece of paper or something
;when you get to #include, it means the END of the autoexecute section.
;gui must be #included first, or it does not work, for some reason...
;YOU probably do NOT need the GUI at all. Delete the line below:

global globalPosition = "Left"
global secondPosition = "Middle"
global thirdPosition = "Right"
global workPC = "No"
global workingDir = "C:\Users\Owner\source\repos\2nd-keyboard\support_files"
;global workingDir = "C:\Users\cxp6696\source\repos\2nd-keyboard\support_files"

if workPC = No
{
    #Include C:\Users\Owner\source\repos\2nd-keyboard\gui.ahk
    #include C:\Users\Owner\source\repos\2nd-keyboard\Almost_All_Premiere_Functions.ahk
    #include C:\Users\Owner\source\repos\2nd-keyboard\After_Effects_Functions.ahk    
    #include C:\Users\Owner\source\repos\2nd-keyboard\ToolTipEx.ahk    
    #include C:\Users\Owner\source\repos\2nd-keyboard\TextFunctions.ahk  
    #include C:\Users\Owner\source\repos\2nd-keyboard\Taran's_Premiere_Mods\PREMIERE_MOD_Right_click_timeline_to_move_playhead.ahk
    #include C:\Users\Owner\source\repos\2nd-keyboard\Taran's_Windows_Mods\Both_Accelerated_Scrolling_1.3_AND_Cursor_click_visualizer.ahk
}
if workPC = Yes
{
    ;#Include C:\Users\cxp6696\source\repos\2nd-keyboard\gui.ahk
    ;#include C:\Users\cxp6696\source\repos\2nd-keyboard\Almost_All_Premiere_Functions.ahk
    ;#include C:\Users\cxp6696\source\repos\2nd-keyboard\After_Effects_Functions.ahk
    ;#include C:\Users\cxp6696\source\repos\2nd-keyboard\ToolTipEx.ahk
    ;#include C:\Users\cxp6696\source\repos\2nd-keyboard\Taran's_Premiere_Mods\PREMIERE_MOD_Right_click_timeline_to_move_playhead.ahk
    ;#include C:\Users\cxp6696\source\repos\2nd-keyboard\Taran's_Windows_Mods\Both_Accelerated_Scrolling_1.3_AND_Cursor_click_visualizer.ahk
}

SetKeyDelay, 0 ;warning ---this was absent for some reason. i just added it back in. IDK if I removed it for a reason or not...

#NoEnv
SendMode Input
#InstallKeybdHook
#InstallMouseHook
#UseHook On

#SingleInstance force ;only one instance may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm ;this may prevent taskbar flashing.
#HotkeyModifierTimeout 60 ; https://autohotkey.com/docs/commands/_HotkeyModifierTimeout.htm
#MaxThreadsPerHotkey 1
#KeyHistory 500 ; https://autohotkey.com/docs/commands/_KeyHistory.htm ; useful for debugging.
; https://www.autohotkey.com/docs/commands/GetKey.htm


detecthiddenwindows, on

SetNumLockState, AlwaysOn ;i think this only works if launched as admin.

;Avoid using stupid CTRL when alt is released https://autohotkey.com/boards/viewtopic.php?f=76&t=57683
;#MenuMaskKey vk07  ; vk07 is (was) unassigned. See my full list of scan codes and virtual keys to see what else is available: 
#MenuMaskKey sc08A  ; vk07 is (was) unassigned. See my full list of scan codes and virtual keys to see what else is available: https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/edit#gid=0

currentTool = "v" ;This is super useful and important for a Premiere script, you'll see...

;static commands
#IfWinActive ahk_exe Adobe Premiere Pro.exe
+1::
{
    ;global VFXkey = +1
   ;instantVFX("position")
   ;instantVFX("position_vertical")
   ;instantVFX("scale")
   ;instantVFX("rotation")
;    instantVFX("anchor_point_vertical")
   return
}
return

#IfWinActive ahk_exe Adobe Premiere Pro.exe
`::
{    
    MouseGetPos, MouseTooltipX, MouseTooltipY
    ToolTip, 
    (
FOLDERS
1. Music
2. Music Ambient
3. Music Ambient (horror)
4. Music Ambient (general)
5. Music Ambient (comedy)
6. Music Ambient (sneaking)
7. Music Ambient (intense)
8. Music Ambient (upbeat)
9. Sounds
10. Sounds Common
11. Clips
12. Images
    ), MouseTooltipX, MouseTooltipY + 20
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}{`}

    If ErrorLevel = EndKey:Escape
    {
        Tooltip
        return
    }

    If ErrorLevel = EndKey:F1
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Music"          
        Run, %explorerpath%
        Tooltip
        return
    }    
    else if ErrorLevel = EndKey:F2
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Music\Ambient"         
        Run, %explorerpath%
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F3
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Music\Ambient\Horror"
        Run, %explorerpath%
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F4
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Music\Ambient\General" 
        Run, %explorerpath%
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F5
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Music\Ambient\Comedy" 
        Run, %explorerpath%
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F6
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Music\Ambient\Sneaking" 
        Run, %explorerpath%
        Tooltip
        return
    }   
    
    If ErrorLevel = EndKey:F7
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Music\Ambient\Intense" 
        Run, %explorerpath%
        Tooltip
        return
    }

    else if ErrorLevel = EndKey:F9
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Music\Ambient\Upbeat"
        Run, %explorerpath%
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F10
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Sounds\aaa Common Sounds" 
        Run, %explorerpath%
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F11
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\Clips" 
        Run, %explorerpath%
        Tooltip
        return
    }     
    If ErrorLevel = EndKey:F12
    {
        explorerpath:= "explorer /e," "G:\Videos\Creative Cloud\Creative Cloud Files\Resources\images" 
        Run, %explorerpath%
        Tooltip
        return
    }
    
    Tooltip
    return  
}
return

#IfWinActive ahk_exe Adobe Premiere Pro.exe
+`::
{
    MouseGetPos, MouseTooltipX, MouseTooltipY
    ToolTip,
    (
1. Positions
2. Sounds
3. Sound Effects (words/effects)
4. Sound Effects (game/crowd/transitions)
5. Sound Effects (dramatic) [obsolete]
6. Music [need to revamp]
7. Color Effects
8. CPSEQ
9. Close ups
10. Misc
    )
    , MouseTooltipX, MouseTooltipY + 20
    
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    ToolTip

    return
}
return

#IfWinActive ahk_exe Adobe Premiere Pro.exe
~1::
{
    first = 1
    second = 1
    position = Left
    sheet = 1
    MouseGetPos, MouseTooltipX, MouseTooltipY
    ToolTip,
    (
E
1. Zoomramp
2. Screenshot
3. Zoom to face and bg
4. Screen Shake
5. Adj Layer 3V
6. Adj Layer 4V
7. Adj layer w/ transform 3
8. Adj layer w/ transform 4
9. Transform Preset
10. black matte fade
11. zoom in rotate in/out
12. stretch face

R
1. Zoom to me close
4. Shaker(1.static 2. bluescreen)
5. lighting pop for zoom(1. punch 2.yoshi)
10. white flash

T
10. Red Flash
    ), MouseTooltipX, MouseTooltipY + 20

    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    
    If OutputVar = Q
    {        
        position = Right
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }
    Else If OutputVar = E
    {
        sheet = 2
        ToolTip, 
        (
E
1. Zoomramp
2. Screenshot
3. Zoom to face and bg
4. Screen Shake
5. Adj Layer 3V
6. Adj Layer 4V
7. Adj layer w/ transform 3
8. Adj layer w/ transform 4
9. Transform Preset
10. black matte fade
11. zoom in rotate in/out
12. stretch face 
        )
        , MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    } 
    Else If OutputVar = R
    {
        sheet = 3
        ToolTip, 
        (
R
1. Zoom to me close
4. Shaker(1.static 2. bluescreen)
5. lighting pop for zoom(1. punch 2.yoshi)
10. white flash
        ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }   
    Else If OutputVar = T
    {
        sheet = 4
        ToolTip, 
        (
T
10. Red Flash
        ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }  
    Else If OutputVar = Y
    {
        sheet = 5
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }  
    If ErrorLevel = EndKey:Escape
    {
        Tooltip
        return
    }        
    if sheet = 1
    {
        ;Close ups moving L to R    
    ;Close ups moving in and out
    If ErrorLevel = EndKey:Escape
    {
        Tooltip
        return
    }
    If ErrorLevel = EndKey:F1
    {
        first = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }    
    else if ErrorLevel = EndKey:F2
    {
        first = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    } 
    else if ErrorLevel = EndKey:F3
    {
        first = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    } 
    else if ErrorLevel = EndKey:F4
    {
        first = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    } 
    else if ErrorLevel = EndKey:F5
    {
        first = 5
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    } 
    else if ErrorLevel = EndKey:F6
    {
        first = 6
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }     
    else if ErrorLevel = EndKey:Left
    {
        if position = Right 
        {
            presetName = CP - Face Slide Right In
            preset(presetName)

            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }

            insertSFX("cartoon-swipe-in")
        }
        else
        {
            presetName = CP - Face Slide Left Out
            preset(presetName)

            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }

            insertSFX("cartoon-swipe-out")
        }
    }
    else if ErrorLevel = EndKey:Right
    {
        if position = Right 
        {
            presetName = CP - Face Slide Right Out
            preset(presetName)

            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }

            insertSFX("cartoon-swipe-out")
        }
        else
        {
            presetName = CP - Face Slide Left In
            preset(presetName)

            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }

            insertSFX("cartoon-swipe-in")
        }
    }

    If ErrorLevel = EndKey:Escape
    {
        Tooltip
        return
    }

    If ErrorLevel = EndKey:F1
    {
        second = 1
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        Tooltip
        return
    }    
    else if ErrorLevel = EndKey:F2
    {
        second = 2
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F3
    {
        second = 3
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F4
    {
        second = 4
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F5
    {
        second = 5
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        Tooltip
        return
    } 
    else if ErrorLevel = EndKey:F6
    {
        second = 6
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        Tooltip
        return
    }   
    
    If ErrorLevel = EndKey:F7
    {
        presetString = CP - Just Face %position% Large
        preset(presetString)
        Send ^!6
        Tooltip
        return
    }
    If ErrorLevel = EndKey:F8
    {
        presetString = CP - Just Face %position% XL
        preset(presetString)
        Send ^!6
        Tooltip
        return
    }

    If ErrorLevel = EndKey:F9
    {
        presetString = CP - C%position% Normal
        preset(presetString)
        Send ^!7
        Tooltip
        return
    }
    If ErrorLevel = EndKey:F10
    {
        presetString = CP - C%position% Medium
        preset(presetString)
        Send ^!7
        Tooltip
        return
    }  

    If ErrorLevel = EndKey:F11
    {
        presetString = CP - C%position% Large
        preset(presetString)
        Send ^!7
        Tooltip
        return
    }
    If ErrorLevel = EndKey:F12
    {
        presetString = CP - C%position% XL
        preset(presetString)
        Send ^!7
        Tooltip
        return
    } 
    If ErrorLevel = EndKey:PrintScreen
    {
        presetString = CP - C%position% XtraL
        preset(presetString)
        Send ^!7
        Tooltip
        return
    }
   }
   if sheet = 2 
   {
        If ErrorLevel = EndKey:F1
        {
            ;insertDoublePreset("CP - Zoom into me", "CP - Zoom into object")
            insertSFX("Me-Overlay-Adjustment-Layer", 3)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }
            preset("CP - Zoomramp")
            ;Send ^!5
            Tooltip
            return
        }
        If ErrorLevel = EndKey:F2
        {
            captureScreenshot()
            ;preset(presetString)
            ;Send ^!5
            Tooltip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            presetString = CP - Zoom into book for reading
            preset(presetString)  
            Tooltip          
            return
        } 

        If ErrorLevel = EndKey:F4
        {
            presetString = CP - Screen Shake Nested Custom
            preset(presetString)  
            Tooltip         
            return
        }

        If ErrorLevel = EndKey:F5
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 3)
            ;presetString = CP - %position% Zoom MtoL
            ;preset(presetString)  
            Tooltip          
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 4)
            ;presetString = CP - %position% Zoom MtoXL
            ;preset(presetString)
            Tooltip
            return
        }  
        
        If ErrorLevel = EndKey:F7
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 3)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }
            preset("CP - Transform Default")
            
            ;presetString = CP - %position% Zoom LtoN
            ;preset(presetString)
            Tooltip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 4)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }
            preset("CP - Transform Default")
            ;presetString = CP - %position% Zoom LtoM
            ;preset(presetString)
            Tooltip
            return
        }
        
        If ErrorLevel = EndKey:F9
        {
            preset("CP - Transform Default")   
            Tooltip         
            return
        }  

        If ErrorLevel = EndKey:F10
        {
            insertSFX("BlackColorMatte", 4)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }
            preset("CP - Fade to 99 opacity")
            
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
            Tooltip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            presetString = Zoom in and Rotate Then Out
            preset(presetString)
            Tooltip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            presetString = CP - Stretched Face Full
            preset(presetString)
            Tooltip
            return
        } 
        If ErrorLevel = EndKey:Escape
        {
            Tooltip
            return
        }
    }

    if sheet = 3
    {
        If ErrorLevel = EndKey:F1
        {
            insertDoublePreset("CP - Zoom into me", "CP - Zoom into closeCenter")
            ;presetString = CP - Zoom into me
            ;preset(presetString)
            ;Send ^!5
            Tooltip
            return
        }
        ; If ErrorLevel = EndKey:F2
        ; {
        ;     captureScreenshot()
        ;     ;preset(presetString)
        ;     ;Send ^!5
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F3
        ; {
        ;     presetString = CP - Zoom into book for reading
        ;     preset(presetString)            
        ;     return
        ; } 

        If ErrorLevel = EndKey:F4
        {
            presetString = The Shaker
            preset(presetString)     
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }

            If OutputVar = 1
            {
                insertSFX("Static Transition Sound")       
            }
            
            If OutputVar = 2
            {
                insertSFX("Blue Screen")
            }
            Tooltip
            return
        }

        If ErrorLevel = EndKey:F5
        {            
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }
            
            If OutputVar = 1
            {
                insertSFX("Me-Overlay-Adjustment-Layer", 3)
                Input, OutputVar, L1, {Escape}              
            }

            presetString = CP - Lighting pop for zoom                       
            preset(presetString)

            Input, OutputVar, L1, {Escape}
            
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }
            If OutputVar = 1
            {
                insertSFX("med punch med")
            }
            If OutputVar = 2
            {
                insertSFX("yoshi tongue")
            }

            Tooltip     
            return
        }
        ; If ErrorLevel = EndKey:F6
        ; {
        ;     insertSFX("Me-Overlay-Adjustment-Layer", 4)
        ;     ;presetString = CP - %position% Zoom MtoXL
        ;     ;preset(presetString)
        ;     return
        ; }  

        ; If ErrorLevel = EndKey:F7
        ; {
        ;     insertSFX("Me-Overlay-Adjustment-Layer", 3)
        ;     Input, OutputVar, L1, {Escape}
        ;     If ErrorLevel = EndKey:Escape
        ;     {
        ;         return
        ;     }
        ;     preset("CP - Transform Default")
            
        ;     ;presetString = CP - %position% Zoom LtoN
        ;     ;preset(presetString)
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F8
        ; {
        ;     insertSFX("Me-Overlay-Adjustment-Layer", 4)
        ;     Input, OutputVar, L1, {Escape}
        ;     If ErrorLevel = EndKey:Escape
        ;     {
        ;         return
        ;     }
        ;     preset("CP - Transform Default")
        ;     ;presetString = CP - %position% Zoom LtoM
        ;     ;preset(presetString)
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F9
        ; {
        ;     preset("CP - Transform Default")
            
        ;     return
        ; }  

        If ErrorLevel = EndKey:F10
        {
            insertSFX("WhiteColorMatte", 4)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }
            preset("CP - White transition flash")
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }

            insertSFX("picture-taken")
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
            Tooltip
            return
        }
        ; If ErrorLevel = EndKey:F11
        ; {
        ;     ;presetString = CP - %position% Zoom XLtoM
        ;     ;preset(presetString)
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F12
        ; {
        ;     ;presetString = CP - %position% Zoom XLtoL
        ;     ;preset(presetString)
        ;     return
        ; } 
        If ErrorLevel = EndKey:Escape
        {
            Tooltip
            return
        }
    }
    if sheet = 4
    {
        If ErrorLevel = EndKey:F10
        {
            insertSFX("RedColorMatte", 4)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }
            preset("CP - White transition flash")
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                Tooltip
                return
            }

            insertSFX("picture-taken")
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
            Tooltip
            return
        }
        If ErrorLevel = EndKey:Escape
        {
            Tooltip
            return
        }
    }
       
}    

return

;basic effects
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~2::
{
    MouseGetPos, MouseTooltipX, MouseTooltipY
    ToolTip,
    (
COMMON SOUNDS
1. Pick up item
2. Mario Jump
3. Error
4. Transitions
5. Zooms
6. Alerts
7. Dramatic
8. Damage
    ), MouseTooltipX, MouseTooltipY + 20

    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    sheet = 1
    key = 1

    If ErrorLevel = EndKey:Escape
    {
        ToolTip
        return
    }
    else if ErrorLevel = EndKey:F1
    {
        key = 1
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
COMMON SOUNDS
Pick up item
    1. Basic
    2-12
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F2
    {
        key = 2
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
COMMON SOUNDS
Mario Jump
    1. Jump
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F3
    {
        key = 3
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
COMMON SOUNDS
Error
    1.Blue Screen
    2.Disconnect
    3.connect
    4.chord
    5.critical stop
    ), MouseTooltipX, MouseTooltipY + 20    
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F4
    {
        key = 4
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
COMMON SOUNDS
Transitions
    1.swipe in
    2.swipe out
    3.whip
    4.street fighter
    5.record scratch
    6.yoshi
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F5
    {
        key = 5
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
COMMON SOUNDS
Zooms  
    1.basic
    2.secondary
    3.third

    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F6
    {
        key = 6
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
COMMON SOUNDS
Alerts
    1.Zelda nes
    2.Zelda N64
    3.MG PS
    4.MG NES
    5.Level up Zelda
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F7
    {
        key = 7
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
COMMON SOUNDS
Dramatic
    1.CinematicBoom
    2.classic
    3.da dum
    4.bumm horn
    5.bum bum bum
    6.heart hit
    7.horn
    8.jurassic park
    9.psycho
    10.quick hit
    11.serial killer hit
    12.heart beat
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F8
    {
        key = 8
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
COMMON SOUNDS
Damage
    1.uppercut
    2.oof grown
    3.oof kid
    4.joe and mac
    5.caleb yaegar
    6.Caleb City Smack
    7.Caleb City Smack 2
    8.Caleb City Smack 4
    9.Caleb City Smack 5
    10.Caleb City Smack 7
    11.bayou billy
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F9
    {
        key = 9
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }            
    else if ErrorLevel = EndKey:F10
    {
        key = 10
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F11
    {
        key = 11
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }     
    else if ErrorLevel = EndKey:F12
    {
        key = 12
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }

    If ErrorLevel = EndKey:Escape
    {
        ToolTip
        return
    }
    else if ErrorLevel = EndKey:F1
    {
        sheet = 1        
    }  
    else if ErrorLevel = EndKey:F2
    {
        sheet = 2        
    }  
    else if ErrorLevel = EndKey:F3
    {
        sheet = 3            
    }
    else if ErrorLevel = EndKey:F4
    {
        sheet = 4                
    }
    else if ErrorLevel = EndKey:F5
    {
        sheet = 5        
    }  
    else if ErrorLevel = EndKey:F6
    {
        sheet = 6        
    }  
    else if ErrorLevel = EndKey:F7
    {
        sheet = 7        
    }
    else if ErrorLevel = EndKey:F8
    {
        sheet = 8        
    }
    else if ErrorLevel = EndKey:F9
    {
        sheet = 9
    }            
    else if ErrorLevel = EndKey:F10
    {
        sheet = 10
    }
    else if ErrorLevel = EndKey:F11
    {
        sheet = 11
    }     
    else if ErrorLevel = EndKey:F12
    {
        sheet = 12
    }
    
    If ErrorLevel = EndKey:Escape
    {
        ToolTip
        return
    }
    ;pick up item
    if key = 1
    {
        If ErrorLevel = EndKey:Escape
        {
            ToolTip
            return
        }
        if sheet = 1
        {
            insertSFX("Pick up item basic")

            ToolTip
            return
        }  
        if sheet = 2
        {
            insertSFX("Pick up item2")

            ToolTip
            return
        }  
        if sheet = 3
        {
            insertSFX("Pick up item3")

            ToolTip
            return
        }
        if sheet = 4
        {
            insertSFX("Pick up item4")

            ToolTip
            return
        }
        if sheet = 5
        {
            insertSFX("Pick up item5")

            ToolTip
            return
        }  
        if sheet = 6
        {
            insertSFX("Pick up item6")
            
            ToolTip
            return
        }  
        if sheet = 7
        {
            insertSFX("Pick up item7")
            
            ToolTip
            return
        }
        if sheet = 8
        {
            insertSFX("Pick up item8")
            
            ToolTip
            return
        }
        if sheet = 9
        {
            insertSFX("Pick up item9")
            
            ToolTip
            return
        }            
        if sheet = 10
        {
            insertSFX("Pick up itemten")
            
            ToolTip
            return
        }
        if sheet = 11
        {
            insertSFX("Pick up itemeleven")
            
            ToolTip
            return
        }     
        if sheet = 12
        {
            insertSFX("Pick up itemtwelve")
            
            ToolTip
            return
        }
    }    

    ;mario jump
    if key = 2
    {
        If ErrorLevel = EndKey:Escape
        {
            
            ToolTip
            return
        }
        ; if sheet = 1
        ; {
            insertSFX("super mario jump")
            
            ToolTip
            return
        ; }  
        ; If ErrorLevel = EndKey:F2
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F3
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F4
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }            
        ; If ErrorLevel = EndKey:F5
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F6
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F7
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }            
        ; If ErrorLevel = EndKey:F10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }     
        ; If ErrorLevel = EndKey:F12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }        
    }     

    ;Error
    if key = 3
    {
        If ErrorLevel = EndKey:Escape
        {
            
            ToolTip
            return
        }
        if sheet = 1
        {
            insertSFX("blue screen of death sound")
            
            ToolTip
            return
        }  
        if sheet = 2
        {
            insertSFX("Windows 7 - HardwareDisconnect")
            
            ToolTip
            return
        }
        if sheet = 3
        {
            insertSFX("Windows 7 - HardwareConnect")
            
            ToolTip
            return
        }
        if sheet = 4
        {
            insertSFX("Windows 10 - Chord")
            
            ToolTip
            return
        }  
        if sheet = 5
        {
            insertSFX("Windows 10 - Critical Stop")
            
            ToolTip
            return
        }  
        ; If ErrorLevel = EndKey:F7
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }            
        ; If ErrorLevel = EndKey:F10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; If ErrorLevel = EndKey:F11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }     
        ; If ErrorLevel = EndKey:F12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
    }     

    ;Transitions
    if key = 4
    {
        If ErrorLevel = EndKey:Escape
        {
            
            ToolTip
            return
        }
        if sheet = 1
        {
            insertSFX("cartoon-swipe-in")
            
            ToolTip
            return
        }  
        if sheet = 2
        {
            insertSFX("cartoon-swipe-out")
            
            ToolTip
            return
        }  
        if sheet = 3
        {
            insertSFX("whip-basic")
            
            ToolTip
            return
        }
        if sheet = 4
        {
            insertSFX("Street Fighter 2 Turbo - Med Punch Med")
            
            ToolTip
            return
        }
        if sheet = 5
        {
            insertSFX("record-scratch")
            
            ToolTip
            return
        }  
        if sheet = 6
        {
            insertSFX("picture-taken")
            
            ToolTip
            return
        }  
        if sheet = 7
        {
            insertSFX("Yoshi tongue Super Mario World sound effect")
            
            ToolTip
            return
        }
        ; if sheet = 8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }            
        ; if sheet = 10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }     
        ; if sheet = 12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
    }     

    ;Zooms
    if key = 5
    {
        If ErrorLevel = EndKey:Escape
        {
            
            ToolTip
            return
        }
        if sheet = 1
        {
            insertSFX("ZoomWindows")
            
            ToolTip
            return
        }  
        if sheet = 2
        {
            insertSFX("Zoom3")
            
            ToolTip
            return
        }  
        if sheet = 3
        {
            insertSFX("Zoombasic")
            
            ToolTip
            return
        }
        ; if sheet = 4
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 5
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }  
        ; if sheet = 6
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }  
        ; if sheet = 7
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }            
        ; if sheet = 10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }     
        ; if sheet = 12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
    }     

    ;Alerts
    if key = 6
    {
        If ErrorLevel = EndKey:Escape
        {
            
            ToolTip
            return
        }
        if sheet = 1
        {
            insertSFX("zelda-secret-nes")
            
            ToolTip
            return
        }  
        if sheet = 2
        {
            insertSFX("zelda-secret-n64")
            
            ToolTip
            return
        }  
        if sheet = 3
        {
            insertSFX("metal gear alert playstation")
            
            ToolTip
            return
        }
        if sheet = 4
        {
            insertSFX("metal gear alert nes")
            
            ToolTip
            return
        }
        if sheet = 5
        {
            insertSFX("Level up - Zelda II")
            
            ToolTip
            return
        }  
        ; if sheet = 6
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }  
        ; if sheet = 7
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }            
        ; if sheet = 10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
        ; if sheet = 11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }     
        ; if sheet = 12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
    }     

    ;Dramatic
    if key = 7
    {
        If ErrorLevel = EndKey:Escape
        {
            
            ToolTip
            return
        }
        if sheet = 1
        {
            insertSFX("CinematicBoom")
            
            ToolTip
            return
        }  
        if sheet = 2
        {
            insertSFX("dramatic-classic")
            
            ToolTip
            return
        }  
        if sheet = 3
        {
            insertSFX("dadum")
            
            ToolTip
            return
        }
        if sheet = 4
        {
            insertSFX("bummhorn sound")
            
            ToolTip
            return
        }
        if sheet = 5
        {
            insertSFX("bumbumbum")
            
            ToolTip
            return
        }  
        if sheet = 6
        {
            insertSFX("hearthit")
            
            ToolTip
            return
        }  
        if sheet = 7
        {
            insertSFX("horn2")
            
            ToolTip
            return
        }
        if sheet = 8
        {
            insertSFX("Jurassicparklike")
            
            ToolTip
            return
        }
        if sheet = 9
        {
            insertSFX("psycho_theme")
            
            ToolTip
            return
        }            
        if sheet = 10
        {
            insertSFX("quickhit")
            
            ToolTip
            return
        }
        if sheet = 11
        {
            insertSFX("serialkillersortahit")
            
            ToolTip
            return
        }     
        if sheet = 12
        {
            insertSFX("heartbeattobuildingsuspense")
            
            ToolTip
            return
        }
    }     

    ;Damage
    if key = 8
    {
        If ErrorLevel = EndKey:Escape
        {
            
            ToolTip
            return
        }
        if sheet = 1
        {
            insertSFX("Uppercut")
            
            ToolTip
            return
        }  
        if sheet = 2
        {
            insertSFX("Oof2")
            
            ToolTip
            return
        }  
        if sheet = 3
        {
            insertSFX("Oof1")
            
            ToolTip
            return
        }
        if sheet = 4
        {
            insertSFX("Joe and Mac Get Hurt")
            
            ToolTip
            return
        }
        if sheet = 5
        {
            insertSFX("Caleb City Yeager Yaegar Yagar")
            
            ToolTip
            return
        }  
        if sheet = 6
        {
            insertSFX("Caleb City Smackbasic")
            
            ToolTip
            return
        }  
        if sheet = 7
        {
            insertSFX("Caleb City Smack2")
            
            ToolTip
            return
        }
        if sheet = 8
        {
            insertSFX("Caleb City Smack4")
            
            ToolTip
            return
        }
        if sheet = 9
        {
            insertSFX("Caleb City Smack5")
            
            ToolTip
            return
        }            
        if sheet = 10
        {
            insertSFX("Caleb City Smack7")
            
            ToolTip
            return
        }
        if sheet = 11
        {
            insertSFX("Adventures of Bayou Billy - Damage")
            
            ToolTip
            return
        }     
        ; if sheet = 12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     
            ToolTip
            return
        ; }
    }       

    ;placeholder
    if key = 9
    {
        If ErrorLevel = EndKey:Escape
        {
            
            ToolTip
            return
        }
        if sheet = 1
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }  
        if sheet = 2
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }  
        if sheet = 3
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }
        if sheet = 4
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }
        if sheet = 5
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }  
        if sheet = 6
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }  
        if sheet = 7
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }
        if sheet = 8
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }
        if sheet = 9
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }            
        if sheet = 10
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }
        if sheet = 11
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }     
        if sheet = 12
        {
            insertSFX("Pickfsvcv")
            
            ToolTip
            return
        }
    }      
}    

return

;SFX - Words/effects
;3 - q,w,e
;Bruh.wav
;Yeet.wav
;Yes.wav
;Nope.wav
;what-sound.wav
;what-sound2.wav
;Oof-1.wav
;Oof-2.wav
;++perfect
;Incredible.wav
;++kobe
;Nice.wav

;gotcha-grab.wav
;Get Over Here Sound Effect!.wav
;tadaa.wav
;Ric Flair Woo.wav
;Nice Shot Clean.wav
;TOASTY!.wav
;that-is-not-correct.wav
;Surprise Motherfucker.wav
;chappelle-gotcha.wav
;FBI Open Up.wav
;Mission Failed We'll Get Em Next Time - Call of Duty.wav
;Run! Marlon Wayans.wav
;help-me.wav
;goteem.wav

;3 - r,t,y
;cash-register-opening.wav
;cash-register.wav
;slotMachine 2.wav
;Fart sound effects.wav
;fart-long.wav
;Fart-short.wav
;bone breaking 4.wav
;bone-break.wav
;picture taken.wav
;Slide.wav
;Slip.wav
;whip.wav
;Punch-1.wav
;Punch-2.wav
;Glitch.wav
;glassbreak.wav
;smack.wav
;stab.wav
;bowling-pins.wav
;dreams.wav
;record-scratch.wav
;splat.wav
;spring.wav
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~3::
{
    data=
    (
1- Words 2,W- Words 2,3- Effects 1,4- Effects 2,5- Effects 3
1. Bruh,1. oof-1,1. Blue Screen Of Death Sound,1. fart-short,1. splat
2. Get-Over-Here-Sound-Effect,2. oof-2,2. bone-break,2. glassbreak,2. spring
3. gotcha-grab,3. perfect,3. bone-breaking-4,3. glitch,3. stab
4. Hello There English accent,4. Ric-Flair-Woo,4. bowling-pins,4. Microphone Tap,4. Static Transition Sound
5. help-me,5. tadaa,5. cash-register,5. Mouseclick,5. undertaker
6. huh,6. Tim Allen Grunt,6. cash-register-clear,6. picture-taken,6. whip
7. incredible,7. that-is-not-correct,7. cash-register-opening,7. punch-1,7. Yoshi-Sound-jump-on
8. kobe,8. toasty,8. crowd gasp Sound Effect,8. punch-2,8. --
9. Mission-Failed-We'll-Get-Em-Next-Time,9. what-sound,9. Ding-dong-sound-effect,9. Quack-Sound-Effect,9. --
10.nice,10.what-sound2,10.dream,10.record-scratch,10.--
11.Nice-Shot-Clean,11.yeet,11.slotMachine-2,11.slide,11.--
12.Nope,12.Yes,12.Fart-sound-effects,12.slip,12.--
PS.Oh my god xgames vine,PS.--,PS.fart-long,PS.smack,PS.--
    )
    ToolTipFont("s10", "Inconsolata")
    ToolTipColor("black", "yellow")
    MouseGetPos, MouseTooltipX, MouseTooltipY
    ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    sheet = 1
    If ErrorLevel = EndKey:Escape
    {        
        ToolTip
        return
    }
    If ErrorLevel = EndKey:F1
    {
        sheet = 1
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
Q- Words 1								
    1. Bruh									
    2. Get-Over-Here-Sound-Effect			
    3. gotcha-grab							
    4. Hello There English accent			
    5. help-me								
    6. huh									
    7. incredible							
    8. kobe									
    9. Mission-Failed-We'll-Get-Em-Next-Time
    10.nice									
    11.Nice-Shot-Clean						
    12.Nope									
    PS.Oh my god xgames vine			

    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If ErrorLevel = EndKey:F2
    {
        sheet = 2
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
W- Words 2							
    1. oof-1							
    2. oof-2							
    3. perfect							
    4. Ric-Flair-Woo					
    5. tadaa							
    6. Tim Allen Grunt - Grunt Tim Allen
    7. that-is-not-correct				
    8. toasty							
    9. what-sound						
    10.what-sound2						
    11.yeet								
    12.Yes								
    PS.--	
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If ErrorLevel = EndKey:F3
    {
        sheet = 3
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
E- Effects 1					
    1. Blue Screen Of Death Sound	
    2. bone-break					
    3. bone-breaking-4				
    4. bowling-pins					
    5. cash-register				
    6. cash-register-clear			
    7. cash-register-opening		
    8. crowd gasp Sound Effect		
    9. Ding-dong-sound-effect		
    10.dream						
    11.slotMachine-2				
    12.Fart-sound-effects			
    PS.fart-long		
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If ErrorLevel = EndKey:F4
    {
        sheet = 4
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
R- Effects 2			
    1. fart-short			
    2. glassbreak			
    3. glitch				
    4. Microphone Tap		
    5. Mouseclick			
    6. picture-taken		
    7. punch-1				
    8. punch-2				
    9. Quack-Sound-Effect	
    10.record-scratch		
    11.slide				
    12.slip					
    PS.smack		
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If ErrorLevel = EndKey:F5
    {
        sheet = 5
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
T- Effects 3
    1. splat
    2. spring
    3. stab
    4. Static Transition Sound
    5. undertaker
    6. whip
    7. Yoshi-Sound-jump-on
    8. --
    9. --
    10.--
    11.--
    12.--
    PS.--
    ), MouseTooltipX, MouseTooltipY + 20
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    ; If OutputVar = Y
    ; {
    ;     sheet = 6
    ;     Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    ; }
    ;words 1
    if sheet = 1
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("Bruh")
            
            ToolTip
            return
        }  
        If ErrorLevel = EndKey:F2
        {
            insertSFX("Get-Over-Here-Sound-Effect")
            
            ToolTip
            return
        }  
        If ErrorLevel = EndKey:F3
        {
            insertSFX("gotcha-grab")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Hello There English accent")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("help-me")
            
            ToolTip
            return
        }  
        If ErrorLevel = EndKey:F6
        {
            insertSFX("huh")
            
            ToolTip
            return
        }  
        If ErrorLevel = EndKey:F7
        {
            insertSFX("incredible")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("kobe")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("Mission-Failed-We'll-Get-Em-Next-Time")
            
            ToolTip
            return
        }            
        If ErrorLevel = EndKey:F10
        {
            insertSFX("nice")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("Nice-Shot-Clean")
            
            ToolTip
            return
        }     
        If ErrorLevel = EndKey:F12
        {
            insertSFX("Nope")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:PrintScreen
        {
            insertSFX("Oh my god xgames vine")
            
            ToolTip
            return
        }      
    } 
    ;words 2
    if sheet = 2 
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("oof-1")
            
            ToolTip
            return
        }  
        If ErrorLevel = EndKey:F2
        {
            insertSFX("oof-2")
            
            ToolTip
            return
        } 
        If ErrorLevel = EndKey:F3
        {
            insertSFX("perfect")
            
            ToolTip
            return
        }  
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Ric-Flair-Woo")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("tadaa")
            
            ToolTip
            return
        }  
        If ErrorLevel = EndKey:F6
        {
            insertSFX("Grunt Tim Allen")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("that-is-not-correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("toasty")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("what-sound")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("what-sound2")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("yeet")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("yes")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:PrintScreen
        {
            ;insertSFX("Oh my god xgames vine")
            
            ToolTip
            return
        }   
    }
    ;effects 1
    if sheet = 3
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("Blue Screen Of Death Sound")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("bone-break")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("bone-breaking-4")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("bowling-pins")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("cash-register")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("cash-register-clear")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("cash-register-opening")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("crowd gasp Sound Effect")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("Ding-dong-sound-effect")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("dream")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("slotMachine-2")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("Fart-sound-effects")
            
            ToolTip
            return
        }

        If ErrorLevel = EndKey:PrintScreen
        {
            insertSFX("fart-long")
            
            ToolTip
            return
        }
    }    
    ;effects 2
    if sheet = 4
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("fart-short")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("glassbreak")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("glitch")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Microphone Tap")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("Mouseclick")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("picture-taken")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("punch-1")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("punch-2")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("Quack-Sound-Effect")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("record-scratch")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("slide")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("slip")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:PrintScreen
        {
            insertSFX("smack")
            
            ToolTip
            return
        }
    }
    ;effects 3
    if sheet = 5 
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("splat")
            
            ToolTip
            return
        } 
        If ErrorLevel = EndKey:F2
        {
            insertSFX("spring")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("stab")
            
            ToolTip
            return
        }     
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Static Transition Sound")
            
            ToolTip
            return
        }     
        If ErrorLevel = EndKey:F5
        {
            insertSFX("undertaker")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("whip")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("Yoshi-Sound-jump-on")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("whip")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("whip")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("whip")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("whip")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("whip")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:PrintScreen
        {
            insertSFX("whip")
            
            ToolTip
            return
        }
    }
    ;misc
    if sheet = 6
    {
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip,
    (
Y- N/A
    1. --
    2. --
    3. --
    4. --
    5. --
    6. --
    7. --
    8. --
    9. --
    10.--
    11.--
    12.--
    PS.--
    ), MouseTooltipX, MouseTooltipY + 20
        If ErrorLevel = EndKey:Escape
        {           
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            ;insertSFX("huh")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F2
        {
            ;insertSFX("Static Transition Sound")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            ;insertSFX("Blue Screen Of Death Sound")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F4
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F6
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
    }
}    

return

;Game/Movie effects - 4 q,w; laughs/crowd - 4 e; transitions 4 r
;4 - q,w
;;;Game/Movie effects - 18
;metal-gear-alert-nes.wav
;metal-gear-alert-playstation.wav
;minion-w.wav
;pick-up-item.wav
;crash-bandicoot-spin.wav
;zelda-secret-n64.wav
;zelda-secret-nes.wav
;super-mario-coin.wav
;super-mario-death-1.wav
;super-mario-death-2.wav
;super-mario-mushroom.wav
;Super Mario Jump.wav
;chest opening - Fortnite.wav
;FamilyFeud-Blip.wav
;GTA 5 Death.wav
;Uppercut.wav
;--CharlieBrownTeacherVoice.wav

;4 - e
;;;laughs/applause/boo - 9
;laugh-1.wav
;laugh-2.wav
;laugh-3.wav
;laughing-earrape.wav
;CharlieMurphyLaugh.wav
;Human-Applause-LargeCrowd01.wav
;Human-Boo-LargeCrowd01.wav
;Human-Boo-SmallCrowd04.wav
;Human-Cheer-MediumCrowd01.wav
;Human-Laugh-SmallCrowd01.wav

;4 - r
;;transitions - 4
;cartoon-swipe-in.wav
;cartoon-swipe-out.wav
;Swoosh.wav
;bubble-pop.wav

#IfWinActive ahk_exe Adobe Premiere Pro.exe
~4::
{
    data=
    (
1- Game Sounds 1,2- Game Sounds 2,3- Crowd 1,4- Transitions
1. crash-bandicoot-spin,1. chest-opening-Fortnite,1. laugh-1,1. cartoon-swipe-in
2. metal-gear-alert-nes,2. FamilyFeud-Blip,2. laugh-2,2. cartoon-swipe-out
3. metal-gear-alert-playstation,3. GTA-5-Death,3. laugh-3,3. swoosh
4. minion-w,4. uppercut,4. laughing-earrape,4. bubble-pop
5. pick-up-item,5. CharlieMurphyLaugh,5. --,5. --
6. super-mario-coin,6. Human-Applause-LargeCrowd01,6. --,6. --
7. super-mario-death-1,7. Human-Boo-LargeCrowd01,7. --,7. --
8. super-mario-death-2,8. Human-Boo-SmallCrowd04,8. --,8. --
9. Super-Mario-Jump,9. Human-Cheer-MediumCrowd01,9. --,9. --
10super-mario-mushroom,10.Human-Laugh-SmallCrowd01,10.--,10.--
11.zelda-secret-n64,11.--,11.--,11.--
12.zelda-secret-nes,12.--,12.--,12.--
PS.--,PS.--,PS.--,PS.--
    )
    ToolTipFont("s10", "Inconsolata")
    ToolTipColor("black", "yellow")
    MouseGetPos, MouseTooltipX, MouseTooltipY
    ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    sheet = 1

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If ErrorLevel = EndKey:F1
    {
        sheet = 1

        data=
            (
Q- Game Sounds 1
1. crash-bandicoot-spin
2. metal-gear-alert-nes
3. metal-gear-alert-playstation
4. minion-w
5. pick-up-item
6. super-mario-coin
7. super-mario-death-1
8. super-mario-death-2
9. Super-Mario-Jump
10super-mario-mushroom
11.zelda-secret-n64
12.zelda-secret-nes
PS.--
            )
            ToolTipFont("s10", "Inconsolata")
            ToolTipColor("black", "yellow")
            MouseGetPos, MouseTooltipX, MouseTooltipY
            ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If ErrorLevel = EndKey:F2
    {
        sheet = 2

        data=
            (
W- Game Sounds 2
1. chest-opening-Fortnite
2. FamilyFeud-Blip
3. GTA-5-Death
4. uppercut
5. CharlieMurphyLaugh
6. Human-Applause-LargeCrowd01
7. Human-Boo-LargeCrowd01
8. Human-Boo-SmallCrowd04
9. Human-Cheer-MediumCrowd01
10.Human-Laugh-SmallCrowd01
11.--
12.--
PS.--
            )
            ToolTipFont("s10", "Inconsolata")
            ToolTipColor("black", "yellow")
            MouseGetPos, MouseTooltipX, MouseTooltipY
            ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If ErrorLevel = EndKey:F3
    {
        sheet = 3

        data=
            (
E- Crowd 1
1. laugh-1
2. laugh-2
3. laugh-3
4. laughing-earrape
5. --
6. --
7. --
8. --
9. --
10.--
11.--
12.--
PS.--
            )
            ToolTipFont("s10", "Inconsolata")
            ToolTipColor("black", "yellow")
            MouseGetPos, MouseTooltipX, MouseTooltipY
            ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If ErrorLevel = EndKey:F4
    {
        sheet = 4

        data=
            (
R- Transitions
1. cartoon-swipe-in
2. cartoon-swipe-out
3. swoosh
4. bubble-pop
5. --
6. --
7. --
8. --
9. --
10.--
11.--
12.--
PS.--
            )
            ToolTipFont("s10", "Inconsolata")
            ToolTipColor("black", "yellow")
            MouseGetPos, MouseTooltipX, MouseTooltipY
            ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    ;Game sounds 1
    if sheet = 1
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("metal-gear-alert-nes")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("metal-gear-alert-playstation")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("minion-w")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("pick-up-item")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("crash-bandicoot-spin")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("zelda-secret-n64")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("zelda-secret-nes")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("super-mario-coin")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("super-mario-death-1")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("super-mario-death-2")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("super-mario-mushroom")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("Super-Mario-Jump")
            
            ToolTip
            return
        }
    }  
    ;Game sounds 2
    if sheet = 2
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("chest-opening-Fortnite")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("FamilyFeud-Blip")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("GTA-5-Death")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("uppercut")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F6
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        } 
    }  
    ;laughs/crowd 1
    if sheet = 3
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("laugh-1")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("laugh-2")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("laugh-3")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("laughing-earrape")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("CharlieMurphyLaugh")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("Human-Applause-LargeCrowd01")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("Human-Boo-LargeCrowd01")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Human-Boo-SmallCrowd04")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("Human-Cheer-MediumCrowd01")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("Human-Laugh-SmallCrowd01")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
    }  
    ;transitions
    if sheet = 4
    {
        If ErrorLevel = EndKey:Escape
        {            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("cartoon-swipe-in")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("cartoon-swipe-out")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("swoosh")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("bubble-pop")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F5
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F6
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F7
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F8
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F9
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F10
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("correct")
            
            ToolTip
            return
        } 
    }  
} 

return

;Dramatic q,w
;5 - q,w
;;dramatic - 21
;Dramatic-alert.wav
;Dramatic-boom and trail off.wav
;Dramatic-boom scratchy.wav
;Dramatic-Boom.wav
;Dramatic-building violin.wav
;Dramatic-building with buzzing.wav
;Dramatic-building with slow fade.wav
;Dramatic-building with wisp 2.wav
;Dramatic-bum bum bum bum bum bum bum bum.wav
;Dramatic-Cinematic-Stinger.wav
;Dramatic-CinematicBoom.wav
;Dramatic-CinematicBoom2.wav
;Dramatic-classic.wav
;Dramatic-do dooo doo doo do dooo.wav
;Dramatic-Electronic woosh.wav
;Dramatic-Evil crack 06.wav
;Dramatic-hard boom.wav
;Dramatic-horn.wav
;Dramatic-Jurassic park like.wav
;Dramatic-lead pipe clang.wav
;explosion.wav
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~5::
{
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    sheet = 1

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If ErrorLevel = EndKey:F1
    {
        sheet = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If ErrorLevel = EndKey:F2
    {
        sheet = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If ErrorLevel = EndKey:F3
    {
        sheet = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If ErrorLevel = EndKey:F4
    {
        sheet = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    ;dramatic
    if sheet = 1
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("Dramatic-alert")
            return
        }  
        If ErrorLevel = EndKey:F2
        {
            insertSFX("Dramatic-boom-and-trail-off")
            return
        }    
        If ErrorLevel = EndKey:F3
        {
            insertSFX("Dramatic-boom-scratchy")
            return
        } 
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Dramatic-Boom")
            return
        } 
        If ErrorLevel = EndKey:F5
        {
            insertSFX("Dramatic-building-violin")
            return
        }  
        If ErrorLevel = EndKey:F6
        {
            insertSFX("Dramatic-building-with-buzzing")
            return
        } 

        If ErrorLevel = EndKey:F7
        {
            insertSFX("Dramatic-building-with-slow-fade")
            return
        }  
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Dramatic-building-with-wisp-2")
            return
        }  
        If ErrorLevel = EndKey:F9
        {
            insertSFX("Dramatic-bum-bum-bum-bum-bum-bum-bum-bum")
            return
        }  
        If ErrorLevel = EndKey:F10
        {
            insertSFX("Dramatic-Cinematic-Stinger")
            return
        }  
        If ErrorLevel = EndKey:F11
        {
            insertSFX("Dramatic-CinematicBoom")
            return
        }  
        If ErrorLevel = EndKey:F12
        {
            insertSFX("Dramatic-CinematicBoom2")
            return
        }   
    }
    ;dramatic
    if sheet = 2
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }

        If ErrorLevel = EndKey:F1
        {
            insertSFX("Dramatic-classic")
            return
        }  
        If ErrorLevel = EndKey:F2
        {
            insertSFX("Dramatic-do-dooo-doo-doo-do-dooo")
            return
        }    
        If ErrorLevel = EndKey:F3
        {
            insertSFX("Dramatic-Electronic-woosh")
            return
        } 
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Dramatic-Evil-crack-06")
            return
        } 
        If ErrorLevel = EndKey:F5
        {
            insertSFX("Dramatic-hard-boom")
            return
        }  
        If ErrorLevel = EndKey:F6
        {
            insertSFX("Dramatic-horn")
            return
        } 

        If ErrorLevel = EndKey:F7
        {
            insertSFX("Dramatic-Jurassic-park-like")
            return
        }  
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Dramatic-lead-pipe-clang")
            return
        }  
        If ErrorLevel = EndKey:F9
        {
            insertSFX("explosion")
            return
        }  
        If ErrorLevel = EndKey:F10
        {
            ;insertSFX("record-scratch")
            return
        }  
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("laugh-2")
            return
        }  
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("pick-up-item")
            return
        }      
    } 
    ;N/A
    if sheet = 3
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("spring")
            return
        }  
        If ErrorLevel = EndKey:F2
        {
            insertSFX("super-mario-death-1")
            return
        } 
        If ErrorLevel = EndKey:F3
        {
            insertSFX("super-mario-death-2")
            return
        }    
        If ErrorLevel = EndKey:F4
        {
            insertSFX("super-mario-mushroom")
            return
        } 
        If ErrorLevel = EndKey:F5
        {
            insertSFX("super-mario-coin")
            return
        } 
        If ErrorLevel = EndKey:F6
        {
            insertSFX("uppercut")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("Nope")
            return
        } 
    } 
    ;N/A  
    if sheet = 4
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("What-sound")
            return
        } 
    }     
}   

return

;Audio Music q,w
;6 - q,w
;;music - 24
;beverly-hills-cop.wav
;cartoon-music-mattia-cupelli.wav
;cinema-sins.wav
;Fluffing-a-duck.wav
;Ghostpocalypse.mp3
;hitman.wav
;Illuminati-Confirmed-Distorted.wav
;Illuminati-Confirmed.wav
;Investigations.wav
;love-me.wav
;Marty-Gots-a-Plan.wav
;MBB.wav
;monkey-spinning.wav
;Piano-and-Ukulele.wav
;pink-panther.wav
;Pizzicato-Playtime.wav
;sad-emotional-piano.wav
;Scheming-Weasel.wav
;Sneaking-Suspense-Jazz.wav
;Sneaky-Adventure.wav
;Sneaky-Snitch.wav
;Spongebob-background-music.wav
;Umbrella-Pants.mp3
;wii-music.wav
;workaday.wav
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~6::
{
    Input, OutputVar, L1, 1,2,3,4,5,6,7,8,9,0,{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    sheet = 1

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If OutputVar = Q
    {
        sheet = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If OutputVar = W
    {
        sheet = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If OutputVar = E
    {
        sheet = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If OutputVar = R
    {
        sheet = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    ;music 1
    if sheet = 1
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertAudio("wii-music")
            return
        }   
        If ErrorLevel = EndKey:F2
        {
            insertAudio("cartoon-music-mattia-cupelli")
            return
        }   
        If ErrorLevel = EndKey:F3
        {
            insertAudio("hitman")
            return
        }   
        If ErrorLevel = EndKey:F4
        {
            insertAudio("investigations")
            return
        }   
        If ErrorLevel = EndKey:F5
        {
            insertAudio("cinema-sins")
            return
        }   
        If ErrorLevel = EndKey:F6
        {
            insertAudio("beverly-hills-cop")
            return
        }   
        If ErrorLevel = EndKey:F7
        {
            insertAudio("Umbrella-pants")
            return
        }   
        If ErrorLevel = EndKey:F8
        {
            insertAudio("Ghostpocalypse")
            return
        }   
        If ErrorLevel = EndKey:F9
        {
            insertAudio("darix-togni")
            return
        }   
        If ErrorLevel = EndKey:F10
        {
            insertAudio("fluffing-a-duck")
            return
        }   
        If ErrorLevel = EndKey:F11
        {
            insertAudio("marty-gots-a-plan")
            return
        }   
        If ErrorLevel = EndKey:F12
        {
            insertAudio("mbb")
            return
        }   
    }
    ;music 2
    if sheet = 2
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        
        If ErrorLevel = EndKey:F1
        {
            insertAudio("Scheming-Weasel")
            return
        }   
        If ErrorLevel = EndKey:F2
        {
            insertAudio("sneaky-suspense-jazz")
            return
        }   
        If ErrorLevel = EndKey:F3
        {
            insertAudio("sneaky-adventure")
            return
        }   
        If ErrorLevel = EndKey:F4
        {
            insertAudio("sneaky-snitch")
            return
        }   
        If ErrorLevel = EndKey:F5
        {
            insertAudio("spongebob-background")
            return
        }   
        If ErrorLevel = EndKey:F6
        {
            insertAudio("batman streets")
            return
        }   
        If ErrorLevel = EndKey:F7
        {
            insertAudio("workaday")
            return
        }   
        If ErrorLevel = EndKey:F8
        {
            insertAudio("monkey-spinning")
            return
        }   
        If ErrorLevel = EndKey:F9
        {
            insertAudio("piano-and-ukalele")
            return
        }   
        If ErrorLevel = EndKey:F10
        {
            insertAudio("sad-emotional-piano")
            return
        }   
        If ErrorLevel = EndKey:F11
        {
            insertAudio("illuminat-confirmed")
            return
        }   
        If ErrorLevel = EndKey:F12
        {
            insertAudio("illuminat-confirmed-distorted")
            return
        }   
    }
    ;music N/A
    if sheet = 3
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertAudio("pizzicato-playtime")
            return
        } 
        If ErrorLevel = EndKey:F2
        {
            insertAudio("love-me")
            return
        } 
        If ErrorLevel = EndKey:F3
        {
            insertAudio("Movement-Proposition")
            return
        } 
        If ErrorLevel = EndKey:F4
        {
            insertAudio("Myuu - The Order's Theme")
            return
        }        
        If ErrorLevel = EndKey:F5
        {
            insertAudio("Blippy Trance")
            return
        }        
        If ErrorLevel = EndKey:F6
        {
            insertAudio("wholesome")
            return
        }        
        If ErrorLevel = EndKey:F7
        {
            insertAudio("Super Mario Bros. 3 Music - Athletic Theme")
            return
        }        
        If ErrorLevel = EndKey:F8
        {
            insertAudio("Dizzy")
            return
        }        
        If ErrorLevel = EndKey:F9
        {
            insertAudio("Deep and Dirty")
            return
        }        
        If ErrorLevel = EndKey:F10
        {
            insertAudio("george street shuffle")
            return
        }        
        If ErrorLevel = EndKey:F11
        {
            insertAudio("antagonist a")
            return
        }        
        If ErrorLevel = EndKey:F12
        {
            ;insertAudio("Myuu - The Order's Theme")
            return
        }                
    }   
    ;music N/A 
    if sheet = 4
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertAudio("pizzicato-playtime")
            return
        } 
        If ErrorLevel = EndKey:F2
        {
            insertAudio("love-me")
            return
        } 
    }   
} 

return

;Color effects
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~7::
{
    data=
    (
Color Effects (Q for no adjustment layer)
1. Black and White [1 | 2 | 3]
2. Cinematic [1. Basic | 2. Orange Tint]
3. Contrast
4. Lumetri
5. Red
6. Green
7. Blue
8. Earthquake
9. Spin Colors
10. Cinematic Bars (1. Top | 2. Bottom)
11. Circular Tunnel
12. Opacity buildup to 100
    )
    ToolTipFont("s10", "Inconsolata")
    ToolTipColor("black", "yellow")
    MouseGetPos, MouseTooltipX, MouseTooltipY
    ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20
    
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{PrintScreen}{Escape}
    sheet = 1
    key = 1
    direct = 0

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If OutputVar = Q
    {
        direct = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{PrintScreen}{Escape}
    }    

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    else if ErrorLevel = EndKey:F1
    {
        key = 1

        data=
        (
        Color Effects (Q for no adjustment layer)
        1. Black and White [1 | 2 | 3]  
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F2
    {
        key = 2

        data=
        (
        Color Effects (Q for no adjustment layer)
        2. Cinematic [1. Basic | 2. Orange Tint]
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20        

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F3
    {
        key = 3

        data=
        (
        Color Effects (Q for no adjustment layer)
        3. Contrast
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F4
    {
        key = 4

        data=
        (
        Color Effects (Q for no adjustment layer)
        4. Lumetri
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F5
    {
        key = 5

        data=
        (
        Color Effects (Q for no adjustment layer)
        5. Red
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F6
    {
        key = 6

        data=
        (
        Color Effects (Q for no adjustment layer)
        6. Green
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F7
    {
        key = 7
    
        data=
        (
        Color Effects (Q for no adjustment layer)
        7. Blue
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20
        
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F8
    {
        key = 8

        data=
        (
        Color Effects (Q for no adjustment layer)
        8. Earthquake
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F9
    {
        key = 9

        data=
        (
        Color Effects (Q for no adjustment layer)
        9. Spin Colors
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20
    
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }            
    else if ErrorLevel = EndKey:F10
    {
        key = 10

        data=
        (
        Color Effects (Q for no adjustment layer)
        10. Cinematic Bars (1. Top | 2. Bottom)
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F11
    {
        key = 11

        data=
        (
        Color Effects (Q for no adjustment layer)
        11. Circular Tunnel
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }     
    else if ErrorLevel = EndKey:F12
    {
        key = 12

        data=
        (
        Color Effects (Q for no adjustment layer)
        12. Opacity buildup to 100
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:PrintScreen
    {
        key = 12

        data=
        (
        Color Effects (Q for no adjustment layer)
        12. Opacity buildup to 100
        )
        ToolTipFont("s10", "Inconsolata")
        ToolTipColor("black", "yellow")
        MouseGetPos, MouseTooltipX, MouseTooltipY
        ToolTip % st_columnize(data, "csv", 1),MouseTooltipX, MouseTooltipY + 20

        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If OutputVar = Q
    {
        direct = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }


    If ErrorLevel = EndKey:Escape
    {        
        ToolTip
        return
    }
    else if ErrorLevel = EndKey:F1
    {
        sheet = 1
    }  
    else if ErrorLevel = EndKey:F2
    {
        sheet = 2
    }  
    else if ErrorLevel = EndKey:F3
    {
        sheet = 3
    }
    else if ErrorLevel = EndKey:F4
    {
        sheet = 4
    }
    else if ErrorLevel = EndKey:F5
    {
        sheet = 5
    }  
    else if ErrorLevel = EndKey:F6
    {
        sheet = 6
    }  
    else if ErrorLevel = EndKey:F7
    {
        sheet = 7
    }
    else if ErrorLevel = EndKey:F8
    {
        sheet = 8
    }
    else if ErrorLevel = EndKey:F9
    {
        sheet = 9
    }            
    else if ErrorLevel = EndKey:F10
    {
        sheet = 10
    }
    else if ErrorLevel = EndKey:F11
    {
        sheet = 11
    }     
    else if ErrorLevel = EndKey:F12
    {
        sheet = 12
    }
    
    If ErrorLevel = EndKey:Escape
    {        
        ToolTip
        return
    }

    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    If OutputVar = Q
    {
        direct = 1        
    }
    ;b/ws pro
    If key = 1
    {
        ;black and white
        If sheet = 1
        {
            If direct = 1
            {
                preset("CP - BW.501HC")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - BW.501HC")
            }            
        }
        If sheet = 2
        {
            If direct = 1
            {
                preset("CP - BW.Cross.Flat")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - BW.Cross.Flat")
            }
        }
        If sheet = 3
        {
            If direct = 1
            {
                preset("CP - BW.HC102")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - BW.HC102")
            }
        }
        ; If sheet = 4
        ; {

        ; }
                
        ToolTip
        return
    } 
    ;cinematic
    If key = 2
    {
        ;basic
        If sheet = 1
        {
            If direct = 1
            {
                preset("CP - Color - Dark black vibrant no color")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Color - Dark black vibrant no color")
            }            
        }
        ;orange tint
        If sheet = 2
        {
            If direct = 1
            {
                preset("CP - Color - Dark black vibrant orange tint")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Color - Dark black vibrant orange tint")
            }
        }        
        
        ToolTip
        return
    } 
    ;contrast
    If key = 3
    {
        ;static
        ; If sheet = 1
        ; {
            If direct = 1
            {
                preset("CP - Deep Contrast")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Deep Contrast")
            }            
        ; }
        ;fade to 
        ; If sheet = 2
        ; {
        ;     If direct = 1
        ;     {
        ;         preset("CP - Fade to M Contrast")
        ;     }
        ;     if direct = 0
        ;     {
        ;         addEffectToAdjustmentLayer("CP - Fade to M Contrast")
        ;     }
        ; }
        ;build and fade
        ; If sheet = 3
        ; {

        ; }
                
        ToolTip
        return
    } 
    ;lumetri
    If key = 4
    {
        ; If sheet = 1
        ; {
            If direct = 1
            {
                preset("CP - Faded Lumetri Color")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Faded Lumetri Color")
            }            
        ; }
        ; If sheet = 2
        ; {
        ;     If direct = 1
        ;     {
        ;         preset("CP - Fade to M Contrast")
        ;     }
        ;     if direct = 0
        ;     {
        ;         addEffectToAdjustmentLayer("CP - Fade to M Contrast")
        ;     }
        ; }
        ; If sheet = 3
        ; {

        ; }
                
        ToolTip
        return
    }    
    ;red
    If key = 5
    {
        ; If sheet = 1
        ; {
            If direct = 1
            {
                preset("CP - Deep Red Coloring")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Deep Red Coloring")
            }
        ; }
        ; If sheet = 2
        ; {
        ;     If direct = 1
        ;     {
        ;         preset("CP - Fade to D Contrast")
        ;     }
        ;     if direct = 0
        ;     {
        ;         addEffectToAdjustmentLayer("CP - Fade to D Contrast")
        ;     }
        ; }
        ; If sheet = 3
        ; {
        ;     If direct = 1
        ;     {
        ;         preset("CP - FQuickinOutDeepContrast")
        ;     }
        ;     if direct = 0
        ;     {
        ;         addEffectToAdjustmentLayer("CP - FQuickinOutDeepContrast")
        ;     }
        ; }
        ; If sheet = 4
        ; {
        ;     If direct = 1
        ;     {
        ;         preset("CP - DContrast Pop In and Out")
        ;     }
        ;     if direct = 0
        ;     {
        ;         addEffectToAdjustmentLayer("CP - DContrast Pop In and Out")
        ;     }
        ;     ;addEffectToAdjustmentLayer("CP - DContrastPop")
        ; }
        
        ToolTip
        return
    }
    ;green
    If key = 6
    {
        If sheet = 1
        {
            ; If direct = 1
            ; {
            ;     preset("CP - BnWStatic")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP - BnWStatic")
            ; }
            ;preset("CP - Black and White")     
        }
        ; If sheet = 2
        ; {
        ;     If direct = 1
        ;     {
        ;         preset("CP - FadeToBnW")
        ;     }
        ;     if direct = 0
        ;     {
        ;         addEffectToAdjustmentLayer("CP - FadeToBnW")
        ;     }
        ;     ;preset("CP - Fade to BnW")
        ; }
        ; If sheet = 3
        ; {
        ;     If direct = 1
        ;     {
        ;         preset("CP - FQuickinOutBW")
        ;     }
        ;     if direct = 0
        ;     {
        ;         addEffectToAdjustmentLayer("CP - FQuickinOutBW")
        ;     }
        ; }
        ; If sheet = 4
        ; {
        ;     If direct = 1
        ;     {
        ;         preset("CP - BnW Pop In and Out")
        ;     }
        ;     if direct = 0
        ;     {
        ;         addEffectToAdjustmentLayer("CP - BnW Pop In and Out")
        ;     }
        ;     ;addEffectToAdjustmentLayer("CP - BnWPop") 
        ; }
        
        ToolTip
        return
    }
    ;blue
    If key = 7
    {
        ; If sheet = 1
        ; {
            If direct = 1
            {
                preset("CP - Deep Blue Coloring")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Deep Blue Coloring")
            }
        ; }
        ; If sheet = 2
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP - Fade to D Contrast")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP - Fade to D Contrast")
            ; }
            ;preset("CP - Fade to D Contrast")
        ; }
        ; If sheet = 3
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
        ; }
        ; If direct = 1
        ; {
        ;     preset("CP - Faded Lumetri Color")
        ; }
        ; if direct = 0
        ; {
        ;     addEffectToAdjustmentLayer("CP - Faded Lumetri Color")
        ; }
        ;preset("CP - Faded Lumetri Color")
        
        ToolTip
        return
    }
    ;earthquake
    If key = 8
    {
        ; If sheet = 1
        ; {
            If direct = 1
            {
                preset("CP - A - GENTLE SHAKE")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - A - GENTLE SHAKE")
            }
        ; }
        ; If sheet = 2
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
            ;preset("CP - Fade to D Contrast")
        ; }
        ; If sheet = 3
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
        ; }
        
        ToolTip
        return
    }
    ;spinning colors
    If key = 9
    {
        ; If sheet = 1
        ; {
            If direct = 1
            {
                preset("CK Color Adjust")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CK Color Adjust")
            }
        ; }
        ; If sheet = 2
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
            ; preset("CP - Fade to D Contrast")
        ; }
        ; If sheet = 3
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
        ; }
        
        ToolTip
        return
    }
    ;cinematic top/bottom
    If key = 10
    {
        If sheet = 1
        {
            If direct = 1
            {
                preset("CP - Black Cinematic Bottom")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Black Cinematic Bottom")
            }
        }
        If sheet = 2
        {
            If direct = 1
            {
                preset("CP - Black Cinematic Top")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Black Cinematic Top")
            }
        }
        If sheet = 3
        {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
        }  
        
        ToolTip
        return
    }
    ;circular tunnel
    If key = 11
    {
        ; If sheet = 1
        ; {
            If direct = 1
            {
                preset("CP - Circle Tunnel Zoom")
            }
            if direct = 0
            {
                addEffectToAdjustmentLayer("CP - Circle Tunnel Zoom")
            }
        ; }
        ; If sheet = 2
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
            ;preset("CP - Fade to D Contrast")
        ; }
        ; If sheet = 3
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
        ; }
        
        ToolTip
        return
    }
    If key = 12
    {
        ; If sheet = 1
        ; {
            preset("CP - Opacity buildup to 100")
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
            ;preset("CP - Deep Contrast")
        ; }
        ; If sheet = 2
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
            ;preset("CP - Fade to D Contrast")
        ; }
        ; If sheet = 3
        ; {
            ; If direct = 1
            ; {
            ;     preset("CP")
            ; }
            ; if direct = 0
            ; {
            ;     addEffectToAdjustmentLayer("CP")
            ; }
        ; }
        
        ToolTip
        return
    }    
        
        return    
} 


return

;CPSEQ
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~8::
{
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
        
    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If ErrorLevel = EndKey:F1
    {
        loadSequence("CPSEQ-tv-no-signal")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F2
    {
        loadSequence("CPSEQ-kiki-wyatt-crazy-look-earrape-laugh")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F3
    {
        loadSequence("CPSEQ-russell-westbrook")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F4
    {
        loadSequence("CPSEQ-draymond-nope")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F5
    {
        loadSequence("CPSEQ-black-girl-laugh")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F6
    {
        loadSequence("CPSEQ-HeadSlap")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F7
    {
        loadSequence("CPSEQ-KidLookingToTheSide")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F8
    {
        loadSequence("CPSEQ-DudeFallsTryingToGrabDrink")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F9
    {
        loadSequence("CPSEQ-kiki-wyatt-crazy-look-earrape-laugh")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F10
    {
        loadSequence("CPSEQ-kiki-wyatt-crazy-look-earrape-laugh")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F11
    {
        loadSequence("CPSEQ-kiki-wyatt-crazy-look-earrape-laugh")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F12
    {
        loadSequence("CPSEQ-kiki-wyatt-crazy-look-earrape-laugh")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    }    

    ;CPSEQ-russell-westbrook
} 

return

;Close ups
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~9::
{
    first = 1
    second = 1
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}   
    
    ;Close ups moving L to R    
    ;Close ups moving in and out
    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If ErrorLevel = EndKey:F1
    {
        first = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    }    
    else if ErrorLevel = EndKey:F2
    {
        first = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F3
    {
        first = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F4
    {
        first = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F5
    {
        first = 5
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F6
    {
        first = 6
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F7
    {
        first = 7
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F8
    {
        first = 8
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F9
    {
        first = 9
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F10
    {
        first = ten
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F11
    {
        first = eleven
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F12
    {
        first = twelve
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:PrintScreen
    {
        first = thirteen
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:ScrollLock
    {
        first = fourteen
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If ErrorLevel = EndKey:F1
    {
        second = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    }    
    else if ErrorLevel = EndKey:F2
    {
        second = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F3
    {
        second = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F4
    {
        second = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F5
    {
        second = 5
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F6
    {
        second = 6
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F7
    {
        second = 7
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F8
    {
        second = 8
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F9
    {
        second = 9
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F10
    {
        second = ten
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F11
    {
        second = eleven
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:F12
    {
        second = twelve
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:PrintScreen
    {
        second = thirteen
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 
    else if ErrorLevel = EndKey:ScrollLock
    {
        second = fourteen
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}
    } 

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    
    ;combinedZoom = CP - Close Zoom %first%to%second%
    combinedZoom = CP - Improved Close %first%to%second%
    If OutputVar = Q
    {        
        preset(combinedZoom)
        return
    }

    insertCloseUpAdjustment(combinedZoom)
    return
}    

return

;Misc
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~0::
{
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    sheet = 1
    
    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If OutputVar = Q
    {
        sheet = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }    
    If OutputVar = W
    {
        sheet = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If OutputVar = E
    {
        sheet = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If OutputVar = R
    {
        sheet = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If OutputVar = T
    {
        sheet = 5
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If ErrorLevel = EndKey:F1
    {                
        if sheet = 1
        {
            presetString = CP - Default Text For Message
            preset(presetString)

            return
        }
        if sheet = 2
        {
            presetString = CP - Default Text for special characters
            preset(presetString)

            return
        }
        if sheet = 3
        {
            presetString = CP - Spherize custom
            preset(presetString)

            return
        }
        if sheet = 4
        {
            presetString = CP - Spherize custom
            preset(presetString)

            return
        }
        if sheet = 5
        {
            presetString = CP - Spherize custom
            preset(presetString)

            return
        }
        return
    }    
    If ErrorLevel = EndKey:F2
    {
        presetString = CP - Spherize custom
        preset(presetString)

        return
    }   
    If ErrorLevel = EndKey:F3
    {
        ;loadSequence("CPSEQ-kiki-wyatt-crazy-look-earrape-laugh")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    }   
    If ErrorLevel = EndKey:F4
    {
        ;loadSequence("CPSEQ-its-clobbering-time")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    }   
    If ErrorLevel = EndKey:F5
    {
        ;loadSequence("CPSEQ-tv-no-signal")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    }   
    If ErrorLevel = EndKey:F6
    {
        ;loadSequence("CPSEQ-draymond-nope")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F7
    {
        ;loadSequence("CPSEQ-draymond-nope")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F8
    {
        ;loadSequence("CPSEQ-draymond-nope")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F9
    {
        ;loadSequence("CPSEQ-draymond-nope")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F10
    {
        ;loadSequence("CPSEQ-draymond-nope")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F11
    {
        ;loadSequence("CPSEQ-draymond-nope")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
        ;CPSEQ-its-clobbering-time
        ;CPSEQ-kiki-wyatt-crazy-look-earrape-laugh
        ;CPSEQ-tv-no-signal
        return
    } 
    If ErrorLevel = EndKey:F12
    {
        ;instantVFX()
        return
    } 
}    

return




