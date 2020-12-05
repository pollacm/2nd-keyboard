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
}
if workPC = Yes
{
    ;#Include C:\Users\cxp6696\source\repos\2nd-keyboard\gui.ahk
    ;#include C:\Users\cxp6696\source\repos\2nd-keyboard\Almost_All_Premiere_Functions.ahk
    ;#include C:\Users\cxp6696\source\repos\2nd-keyboard\After_Effects_Functions.ahk
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
/* ~1::
{
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    position = %globalPosition%
    size = S
    If OutputVar = Q
    {
        position = %secondPosition%
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If OutputVar = W
    {
        position = %thirdPosition%
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If OutputVar = A
    {
        size = S
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If OutputVar = S
    {
        size = M
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If OutputVar = D
    {
        size = L
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }        
    If ErrorLevel = EndKey:Escape
    {
        return
    }

    If ErrorLevel = EndKey:F1
    {
        presetString = CP - %position% Static Normal
        preset(presetString)
        Send ^!2
        return
    }
    If ErrorLevel = EndKey:F2
    {
        presetString = CP - %position% Static Medium
        preset(presetString)
        Send ^!1
        return
    }
    If ErrorLevel = EndKey:F3
    {
        presetString = CP - %position% Static Large
        preset(presetString)
        Send ^!3
        return
    }
    If ErrorLevel = EndKey:F4
    {
        presetString = CP - %position% Static XL
        preset(presetString)
        Send ^!4
        return
    } 

    If ErrorLevel = EndKey:F5
    {
        presetString = CP - Just Face %position% Large
        preset(presetString)
        Send ^!6
        return
    }
    If ErrorLevel = EndKey:F6
    {
        presetString = CP - Just Face %position% XL
        preset(presetString)
        Send ^!6
        return
    }
    ;If ErrorLevel = EndKey:F7
    ;{
    ;    presetString = CP - Just Face Right Large
    ;    preset(presetString)
    ;    Send ^!6
    ;    return
    ;}
    ;If ErrorLevel = EndKey:F8
    ;{
    ;    presetString = CP - Just Face Right XL
    ;    preset(presetString)
    ;    Send ^!6
    ;    return
    ;}
    If ErrorLevel = EndKey:F7
    {
        if size = S
        {
            presetString = CP - %position% Enhance Small to Medium to XL
        }
        if size = M
        {
            presetString = CP - %position% Enhance Medium to Large to XXL
        }
        if size = L
        {
            presetString = CP - %position% Enhance Large to XL to XXL
        }

        preset(presetString)
        Send ^!6
        return
    }
    If ErrorLevel = EndKey:F8
    {
        presetString = CP - %position% Enhance Small to Large to XXL
        preset(presetString)
        Send ^!6
        return
    }

    If ErrorLevel = EndKey:F9
    {
        presetString = CP - C%position% Normal
        preset(presetString)
        Send ^!7
        return
    }
    If ErrorLevel = EndKey:F10
    {
        presetString = CP - C%position% Medium
        preset(presetString)
        Send ^!7
        return
    }  

    If ErrorLevel = EndKey:F11
    {
        presetString = CP - C%position% Large
        preset(presetString)
        Send ^!7
        return
    }
    If ErrorLevel = EndKey:F12
    {
        presetString = CP - C%position% XL
        preset(presetString)
        Send ^!7
        return
    } 
    If ErrorLevel = EndKey:PrintScreen
    {
        presetString = CP - C%position% XtraL
        preset(presetString)
        Send ^!7
        return
    }   
}    

return

;Zoom moving
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~2::
{
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    position = %globalPosition%
    sheet = 1

    If OutputVar = Q
    {
        position = %secondPosition%
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    If OutputVar = W
    {
        position = %thirdPosition%
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    } 
    If OutputVar = E
    {
        sheet = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    } 
    If OutputVar = R
    {
        sheet = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }    
    If ErrorLevel = EndKey:Escape
    {
        return
    }    
    if sheet = 1
    {
        If ErrorLevel = EndKey:F1
        {
            presetString = CP - %position% Zoom NtoM
            preset(presetString)
            Send ^!5
            return
        }
        If ErrorLevel = EndKey:F2
        {
            presetString = CP - %position% Zoom NtoL
            preset(presetString)
            Send ^!5
            return
        }
        If ErrorLevel = EndKey:F3
        {
            presetString = CP - %position% Zoom NtoXL
            preset(presetString)
            Send ^!5
            return
        } 

        If ErrorLevel = EndKey:F4
        {
            presetString = CP - %position% Zoom MtoN
            preset(presetString)
            Send ^!5
            return
        }
        If ErrorLevel = EndKey:F5
        {
            presetString = CP - %position% Zoom MtoL
            preset(presetString)
            Send ^!5
            return
        }
        If ErrorLevel = EndKey:F6
        {
            presetString = CP - %position% Zoom MtoXL
            preset(presetString)
            Send ^!5
            return
        }  

        If ErrorLevel = EndKey:F7
        {
            presetString = CP - %position% Zoom LtoN
            preset(presetString)
            Send ^!5
            return
        }
        If ErrorLevel = EndKey:F8
        {
            presetString = CP - %position% Zoom LtoM
            preset(presetString)
            Send ^!5
            return
        }
        If ErrorLevel = EndKey:F9
        {
            presetString = CP - %position% Zoom LtoXL
            preset(presetString)
            Send ^!5
            return
        }  

        If ErrorLevel = EndKey:F10
        {
            presetString = CP - %position% Zoom XLtoN
            preset(presetString)
            Send ^!5
            return
        }
        If ErrorLevel = EndKey:F11
        {
            presetString = CP - %position% Zoom XLtoM
            preset(presetString)
            Send ^!5
            return
        }
        If ErrorLevel = EndKey:F12
        {
            presetString = CP - %position% Zoom XLtoL
            preset(presetString)
            Send ^!5
            return
        } 
    }
    ;double presets
    if sheet = 2 
    {
        If ErrorLevel = EndKey:F1
        {
            insertDoublePreset("CP - Zoom into me", "CP - Zoom into object")
            ;presetString = CP - Zoom into me
            ;preset(presetString)
            ;Send ^!5
            return
        }
        If ErrorLevel = EndKey:F2
        {
            captureScreenshot()
            ;preset(presetString)
            ;Send ^!5
            return
        }
        If ErrorLevel = EndKey:F3
        {
            presetString = CP - Zoom into book for reading
            preset(presetString)            
            return
        } 

        If ErrorLevel = EndKey:F4
        {
            presetString = CP - Screen Shake Nested Custom
            preset(presetString)            
            return
        }

        If ErrorLevel = EndKey:F5
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 3)
            ;presetString = CP - %position% Zoom MtoL
            ;preset(presetString)            
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 4)
            ;presetString = CP - %position% Zoom MtoXL
            ;preset(presetString)
            return
        }  

        If ErrorLevel = EndKey:F7
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 3)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }
            preset("CP - Transform Default")
            
            ;presetString = CP - %position% Zoom LtoN
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 4)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }
            preset("CP - Transform Default")
            ;presetString = CP - %position% Zoom LtoM
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F9
        {
            preset("CP - Transform Default")            
            return
        }  

        If ErrorLevel = EndKey:F10
        {
            insertSFX("BlackColorMatte", 4)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }
            preset("CP - Fade to 99 opacity")
            
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F11
        {
            presetString = Zoom in and Rotate Then Out
            preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F12
        {
            presetString = CP - Stretched Face Full
            preset(presetString)
            return
        } 
        If ErrorLevel = EndKey:Escape
        {
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
            return
        }

        If ErrorLevel = EndKey:F5
        {            
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
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
                return
            }
            preset("CP - White transition flash")
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }

            insertSFX("picture-taken")
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
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
            return
        }
    }
     
}    

return 
*/
~1::
{
    first = 1
    second = 1
    position = Left
    sheet = 1
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    
    If OutputVar = Q
    {        
        position = Right
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }
    Else If OutputVar = E
    {
        sheet = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    } 
    Else If OutputVar = R
    {
        sheet = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }   
    Else If OutputVar = T
    {
        sheet = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }  
    Else If OutputVar = Y
    {
        sheet = 5
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}{ScrollLock}{Left}{Right}
    }  
    If ErrorLevel = EndKey:Escape
    {
        return
    }        
    if sheet = 1
    {
        ;Close ups moving L to R    
    ;Close ups moving in and out
    If ErrorLevel = EndKey:Escape
    {
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
                return
            }

            insertSFX("cartoon-swipe-in")
        }
    }

    If ErrorLevel = EndKey:Escape
    {
        return
    }

    If ErrorLevel = EndKey:F1
    {
        second = 1
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        return
    }    
    else if ErrorLevel = EndKey:F2
    {
        second = 2
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        return
    } 
    else if ErrorLevel = EndKey:F3
    {
        second = 3
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        return
    } 
    else if ErrorLevel = EndKey:F4
    {
        second = 4
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        return
    } 
    else if ErrorLevel = EndKey:F5
    {
        second = 5
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        return
    } 
    else if ErrorLevel = EndKey:F6
    {
        second = 6
        combinedZoom = CP - Improved %position% %first%to%second%

        preset(combinedZoom)
        return
    }   
    
    If ErrorLevel = EndKey:F7
    {
        presetString = CP - Just Face %position% Large
        preset(presetString)
        Send ^!6
        return
    }
    If ErrorLevel = EndKey:F8
    {
        presetString = CP - Just Face %position% XL
        preset(presetString)
        Send ^!6
        return
    }

    If ErrorLevel = EndKey:F9
    {
        presetString = CP - C%position% Normal
        preset(presetString)
        Send ^!7
        return
    }
    If ErrorLevel = EndKey:F10
    {
        presetString = CP - C%position% Medium
        preset(presetString)
        Send ^!7
        return
    }  

    If ErrorLevel = EndKey:F11
    {
        presetString = CP - C%position% Large
        preset(presetString)
        Send ^!7
        return
    }
    If ErrorLevel = EndKey:F12
    {
        presetString = CP - C%position% XL
        preset(presetString)
        Send ^!7
        return
    } 
    If ErrorLevel = EndKey:PrintScreen
    {
        presetString = CP - C%position% XtraL
        preset(presetString)
        Send ^!7
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
                return
            }
            preset("CP - Zoomramp")
            ;Send ^!5
            return
        }
        If ErrorLevel = EndKey:F2
        {
            captureScreenshot()
            ;preset(presetString)
            ;Send ^!5
            return
        }
        If ErrorLevel = EndKey:F3
        {
            presetString = CP - Zoom into book for reading
            preset(presetString)            
            return
        } 

        If ErrorLevel = EndKey:F4
        {
            presetString = CP - Screen Shake Nested Custom
            preset(presetString)            
            return
        }

        If ErrorLevel = EndKey:F5
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 3)
            ;presetString = CP - %position% Zoom MtoL
            ;preset(presetString)            
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 4)
            ;presetString = CP - %position% Zoom MtoXL
            ;preset(presetString)
            return
        }  

        If ErrorLevel = EndKey:F7
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 3)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }
            preset("CP - Transform Default")
            
            ;presetString = CP - %position% Zoom LtoN
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Me-Overlay-Adjustment-Layer", 4)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }
            preset("CP - Transform Default")
            ;presetString = CP - %position% Zoom LtoM
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F9
        {
            preset("CP - Transform Default")            
            return
        }  

        If ErrorLevel = EndKey:F10
        {
            insertSFX("BlackColorMatte", 4)
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }
            preset("CP - Fade to 99 opacity")
            
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F11
        {
            presetString = Zoom in and Rotate Then Out
            preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F12
        {
            presetString = CP - Stretched Face Full
            preset(presetString)
            return
        } 
        If ErrorLevel = EndKey:Escape
        {
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
            return
        }

        If ErrorLevel = EndKey:F5
        {            
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
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
                return
            }
            preset("CP - White transition flash")
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }

            insertSFX("picture-taken")
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
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
                return
            }
            preset("CP - White transition flash")
            Input, OutputVar, L1, {Escape}
            If ErrorLevel = EndKey:Escape
            {
                return
            }

            insertSFX("picture-taken")
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:Escape
        {
            return
        }
    }
       
}    

return

;basic effects
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~2::
{
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    sheet = 1
    key = 1

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    else if ErrorLevel = EndKey:F1
    {
        key = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F2
    {
        key = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F3
    {
        key = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F4
    {
        key = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F5
    {
        key = 5
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F6
    {
        key = 6
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F7
    {
        key = 7
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F8
    {
        key = 8
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
        return
    }
    ;pick up item
    if key = 1
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        if sheet = 1
        {
            insertSFX("Pick up item basic")
            return
        }  
        if sheet = 2
        {
            insertSFX("Pick up item2")
            return
        }  
        if sheet = 3
        {
            insertSFX("Pick up item3")
            return
        }
        if sheet = 4
        {
            insertSFX("Pick up item4")
            return
        }
        if sheet = 5
        {
            insertSFX("Pick up item5")
            return
        }  
        if sheet = 6
        {
            insertSFX("Pick up item6")
            return
        }  
        if sheet = 7
        {
            insertSFX("Pick up item7")
            return
        }
        if sheet = 8
        {
            insertSFX("Pick up item8")
            return
        }
        if sheet = 9
        {
            insertSFX("Pick up item9")
            return
        }            
        if sheet = 10
        {
            insertSFX("Pick up itemten")
            return
        }
        if sheet = 11
        {
            insertSFX("Pick up itemeleven")
            return
        }     
        if sheet = 12
        {
            insertSFX("Pick up itemtwelve")
            return
        }
    }    

    ;mario jump
    if key = 2
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        ; if sheet = 1
        ; {
            insertSFX("super mario jump")
            return
        ; }  
        ; If ErrorLevel = EndKey:F2
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F3
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F4
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }            
        ; If ErrorLevel = EndKey:F5
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F6
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F7
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }            
        ; If ErrorLevel = EndKey:F10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }     
        ; If ErrorLevel = EndKey:F12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }        
    }     

    ;Error
    if key = 3
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        if sheet = 1
        {
            insertSFX("blue screen of death sound")
            return
        }  
        if sheet = 2
        {
            insertSFX("Windows 7 - HardwareDisconnect")
            return
        }
        if sheet = 3
        {
            insertSFX("Windows 7 - HardwareConnect")
            return
        }
        if sheet = 4
        {
            insertSFX("Windows 10 - Chord")
            return
        }  
        if sheet = 5
        {
            insertSFX("Windows 10 - Critical Stop")
            return
        }  
        ; If ErrorLevel = EndKey:F7
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }            
        ; If ErrorLevel = EndKey:F10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; If ErrorLevel = EndKey:F11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }     
        ; If ErrorLevel = EndKey:F12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
    }     

    ;Transitions
    if key = 4
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        if sheet = 1
        {
            insertSFX("cartoon-swipe-in")
            return
        }  
        if sheet = 2
        {
            insertSFX("cartoon-swipe-out")
            return
        }  
        if sheet = 3
        {
            insertSFX("whip-basic")
            return
        }
        if sheet = 4
        {
            insertSFX("Street Fighter 2 Turbo - Med Punch Med")
            return
        }
        if sheet = 5
        {
            insertSFX("record-scratch")
            return
        }  
        if sheet = 6
        {
            insertSFX("picture-taken")
            return
        }  
        if sheet = 7
        {
            insertSFX("Yoshi tongue Super Mario World sound effect")
            return
        }
        ; if sheet = 8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }            
        ; if sheet = 10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }     
        ; if sheet = 12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
    }     

    ;Zooms
    if key = 5
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        if sheet = 1
        {
            insertSFX("ZoomWindows")
            return
        }  
        if sheet = 2
        {
            insertSFX("Zoom3")
            return
        }  
        if sheet = 3
        {
            insertSFX("Zoombasic")
            return
        }
        ; if sheet = 4
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 5
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }  
        ; if sheet = 6
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }  
        ; if sheet = 7
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }            
        ; if sheet = 10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }     
        ; if sheet = 12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
    }     

    ;Alerts
    if key = 6
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        if sheet = 1
        {
            insertSFX("zelda-secret-nes")
            return
        }  
        if sheet = 2
        {
            insertSFX("zelda-secret-n64")
            return
        }  
        if sheet = 3
        {
            insertSFX("metal gear alert playstation")
            return
        }
        if sheet = 4
        {
            insertSFX("metal gear alert nes")
            return
        }
        if sheet = 5
        {
            insertSFX("Level up - Zelda II")
            return
        }  
        ; if sheet = 6
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }  
        ; if sheet = 7
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 8
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 9
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }            
        ; if sheet = 10
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
        ; if sheet = 11
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }     
        ; if sheet = 12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
    }     

    ;Dramatic
    if key = 7
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        if sheet = 1
        {
            insertSFX("CinematicBoom")
            return
        }  
        if sheet = 2
        {
            insertSFX("dramatic-classic")
            return
        }  
        if sheet = 3
        {
            insertSFX("dadum")
            return
        }
        if sheet = 4
        {
            insertSFX("bummhorn sound")
            return
        }
        if sheet = 5
        {
            insertSFX("bumbumbum")
            return
        }  
        if sheet = 6
        {
            insertSFX("hearthit")
            return
        }  
        if sheet = 7
        {
            insertSFX("horn2")
            return
        }
        if sheet = 8
        {
            insertSFX("Jurassicparklike")
            return
        }
        if sheet = 9
        {
            insertSFX("psycho_theme")
            return
        }            
        if sheet = 10
        {
            insertSFX("quickhit")
            return
        }
        if sheet = 11
        {
            insertSFX("serialkillersortahit")
            return
        }     
        if sheet = 12
        {
            insertSFX("heartbeattobuildingsuspense")
            return
        }
    }     

    ;Damage
    if key = 8
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        if sheet = 1
        {
            insertSFX("Uppercut")
            return
        }  
        if sheet = 2
        {
            insertSFX("Oof2")
            return
        }  
        if sheet = 3
        {
            insertSFX("Oof1")
            return
        }
        if sheet = 4
        {
            insertSFX("Joe and Mac Get Hurt")
            return
        }
        if sheet = 5
        {
            insertSFX("Caleb City Yeager Yaegar Yagar")
            return
        }  
        if sheet = 6
        {
            insertSFX("Caleb City Smackbasic")
            return
        }  
        if sheet = 7
        {
            insertSFX("Caleb City Smack2")
            return
        }
        if sheet = 8
        {
            insertSFX("Caleb City Smack4")
            return
        }
        if sheet = 9
        {
            insertSFX("Caleb City Smack5")
            return
        }            
        if sheet = 10
        {
            insertSFX("Caleb City Smack7")
            return
        }
        if sheet = 11
        {
            insertSFX("Adventures of Bayou Billy - Damage")
            return
        }     
        ; if sheet = 12
        ; {
        ;     insertSFX("Pickfsvcv")
        ;     return
        ; }
    }       

    ;placeholder
    if key = 9
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        if sheet = 1
        {
            insertSFX("Pickfsvcv")
            return
        }  
        if sheet = 2
        {
            insertSFX("Pickfsvcv")
            return
        }  
        if sheet = 3
        {
            insertSFX("Pickfsvcv")
            return
        }
        if sheet = 4
        {
            insertSFX("Pickfsvcv")
            return
        }
        if sheet = 5
        {
            insertSFX("Pickfsvcv")
            return
        }  
        if sheet = 6
        {
            insertSFX("Pickfsvcv")
            return
        }  
        if sheet = 7
        {
            insertSFX("Pickfsvcv")
            return
        }
        if sheet = 8
        {
            insertSFX("Pickfsvcv")
            return
        }
        if sheet = 9
        {
            insertSFX("Pickfsvcv")
            return
        }            
        if sheet = 10
        {
            insertSFX("Pickfsvcv")
            return
        }
        if sheet = 11
        {
            insertSFX("Pickfsvcv")
            return
        }     
        if sheet = 12
        {
            insertSFX("Pickfsvcv")
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
    If OutputVar = Y
    {
        sheet = 6
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    ;words 1
    if sheet = 1
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("Bruh")
            return
        }  
        If ErrorLevel = EndKey:F2
        {
            insertSFX("yeet")
            return
        }  
        If ErrorLevel = EndKey:F3
        {
            insertSFX("Yes")
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Nope")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("what-sound")
            return
        }  
        If ErrorLevel = EndKey:F6
        {
            insertSFX("what-sound2")
            return
        }  
        If ErrorLevel = EndKey:F7
        {
            insertSFX("Oof-1")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Oof-2")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("perfect")
            return
        }            
        If ErrorLevel = EndKey:F10
        {
            insertSFX("incredible")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("kobe")
            return
        }     
        If ErrorLevel = EndKey:F12
        {
            insertSFX("nice")
            return
        }
    } 
    ;words 2
    if sheet = 2 
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("gotcha-grab")
            return
        }  
        If ErrorLevel = EndKey:F2
        {
            insertSFX("Get-Over-Here-Sound-Effect")
            return
        } 
        If ErrorLevel = EndKey:F3
        {
            insertSFX("tadaa")
            return
        }  
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Ric-Flair-Woo")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("Nice-Shot-Clean")
            return
        }  
        If ErrorLevel = EndKey:F6
        {
            insertSFX("toasty")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("that-is-not-correct")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Grunt Tim Allen")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("Hello There English accent")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("Mission-Failed-We'll-Get-Em-Next-Time")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("Oh my god xgames vine")
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("help-me")
            return
        }
    }
    ;effects 1
    if sheet = 3
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("cash-register-opening")
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("cash-register")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("slotMachine-2")
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Fart-sound-effects")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("fart-long")
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("fart-short")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("bone-breaking-4")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("bone-break")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("picture-taken")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("slide")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("slip")
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("whip")
            return
        }
    }    
    ;effects 2
    if sheet = 4
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("punch-1")
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("punch-2")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("glitch")
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("glassbreak")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("smack")
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("stab")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("bowling-pins")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("dreams")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("record-scratch")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("splat")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("spring")
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("Quack-Sound-Effect")
            return
        }
    }
    ;effects 3
    if sheet = 5 
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("Yoshi-Sound-jump-on")
            return
        } 
        If ErrorLevel = EndKey:F2
        {
            insertSFX("Ding-dong-sound-effect")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("Microphone Tap")
            return
        }     
        If ErrorLevel = EndKey:F4
        {
            insertSFX("Mouseclick")
            return
        }     
        If ErrorLevel = EndKey:F5
        {
            insertSFX("crowd gasp Sound Effect")
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("undertaker")
            return
        }
    }
    ;misc
    if sheet = 6
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("huh")
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("Static Transition Sound")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("Blue Screen Of Death Sound")
            return
        }
        If ErrorLevel = EndKey:F4
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F6
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("correct")
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
    ;Game sounds 1
    if sheet = 1
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("metal-gear-alert-nes")
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("metal-gear-alert-playstation")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("minion-w")
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("pick-up-item")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("crash-bandicoot-spin")
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("zelda-secret-n64")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("zelda-secret-nes")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("super-mario-coin")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("super-mario-death-1")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("super-mario-death-2")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("super-mario-mushroom")
            return
        }
        If ErrorLevel = EndKey:F12
        {
            insertSFX("Super-Mario-Jump")
            return
        }
    }  
    ;Game sounds 2
    if sheet = 2
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("chest-opening-Fortnite")
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("FamilyFeud-Blip")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("GTA-5-Death")
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("uppercut")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F6
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("correct")
            return
        } 
    }  
    ;laughs/crowd 1
    if sheet = 3
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("laugh-1")
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("laugh-2")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("laugh-3")
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("laughing-earrape")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            insertSFX("CharlieMurphyLaugh")
            return
        }
        If ErrorLevel = EndKey:F6
        {
            insertSFX("Human-Applause-LargeCrowd01")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("Human-Boo-LargeCrowd01")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            insertSFX("Human-Boo-SmallCrowd04")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("Human-Cheer-MediumCrowd01")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("Human-Laugh-SmallCrowd01")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("correct")
            return
        }
    }  
    ;transitions
    if sheet = 4
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("cartoon-swipe-in")
            return
        }
        If ErrorLevel = EndKey:F2
        {
            insertSFX("cartoon-swipe-out")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            insertSFX("swoosh")
            return
        }
        If ErrorLevel = EndKey:F4
        {
            insertSFX("bubble-pop")
            return
        }
        If ErrorLevel = EndKey:F5
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F6
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F8
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;insertSFX("correct")
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
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
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
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }    

    If ErrorLevel = EndKey:Escape
    {
        return
    }
    else if ErrorLevel = EndKey:F1
    {
        key = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F2
    {
        key = 2
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F3
    {
        key = 3
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F4
    {
        key = 4
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F5
    {
        key = 5
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F6
    {
        key = 6
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }  
    else if ErrorLevel = EndKey:F7
    {
        key = 7
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }
    else if ErrorLevel = EndKey:F8
    {
        key = 8
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
    If OutputVar = Q
    {
        direct = 1
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    }


    If ErrorLevel = EndKey:Escape
    {
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
        return
    }    
        
        return    
} 


return

;VFX
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
        instantVFX()
        return
    } 
}    

return




