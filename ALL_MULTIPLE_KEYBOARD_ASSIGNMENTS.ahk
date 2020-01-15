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
global workPC = "Yes"

if workPC = No
{    
    ;global workingDir = "C:\Users\Owner\source\repos\2nd-keyboard\support_files"
    ;#Include C:\Users\Owner\source\repos\2nd-keyboard\gui.ahk
    ;#include C:\Users\Owner\source\repos\2nd-keyboard\Almost_All_Premiere_Functions.ahk
    ;#include C:\Users\Owner\source\repos\2nd-keyboard\After_Effects_Functions.ahk
}

if workPC = Yes
{
    global workingDir = "C:\Users\cxp6696\source\repos\2nd-keyboard\support_files"
    #Include C:\Users\cxp6696\source\repos\2nd-keyboard\gui.ahk
    #include C:\Users\cxp6696\source\repos\2nd-keyboard\Almost_All_Premiere_Functions.ahk
    #include C:\Users\cxp6696\source\repos\2nd-keyboard\After_Effects_Functions.ahk
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
~1::
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
            ;presetString = CP - %position% Zoom LtoXL
            ;preset(presetString)
            return
        }  

        If ErrorLevel = EndKey:F10
        {
            ;presetString = CP - %position% Zoom XLtoN
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F11
        {
            ;presetString = CP - %position% Zoom XLtoM
            ;preset(presetString)
            return
        }
        If ErrorLevel = EndKey:F12
        {
            ;presetString = CP - %position% Zoom XLtoL
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
            insertSFX("Surprise-Motherfucker")
            return
        }
        If ErrorLevel = EndKey:F9
        {
            insertSFX("fbi-open-up")
            return
        }
        If ErrorLevel = EndKey:F10
        {
            insertSFX("Mission-Failed-We'll-Get-Em-Next-Time")
            return
        }
        If ErrorLevel = EndKey:F11
        {
            insertSFX("Run!-Marlon-Wayans")
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
            ;insertSFX("correct")
            return
        }
        If ErrorLevel = EndKey:F3
        {
            ;insertSFX("correct")
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
            insertAudio("pink-panther")
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
    
    If ErrorLevel = EndKey:Escape
    {
        return
    }
    ;mid contrast
    If ErrorLevel = EndKey:F1
    {
        If sheet = 1
        {
            addEffectToAdjustmentLayer("CP - Mid Contrast")
        }
        If sheet = 2
        {
            addEffectToAdjustmentLayer("CP - Fade to M Contrast")
        }
        If sheet = 3
        {

        }
        
        return
    }    
    If ErrorLevel = EndKey:F2
    {
        If sheet = 1
        {
            addEffectToAdjustmentLayer("CP - Deep Contrast")
        }
        If sheet = 2
        {
            addEffectToAdjustmentLayer("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }

        return
    }
    If ErrorLevel = EndKey:F3
    {
        If sheet = 1
        {
            ;preset("CP - Black and White")
            addEffectToAdjustmentLayer("CP - FinOutBnW")        
        }
        If sheet = 2
        {
            ;preset("CP - Fade to BnW")
            addEffectToAdjustmentLayer("CP - FQuickinOutBW")
        }
        If sheet = 3
        {
            addEffectToAdjustmentLayer("CP - BnWPop") 
        }
        return
    }
    If ErrorLevel = EndKey:F4
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }
        addEffectToAdjustmentLayer("CP - Faded Lumetri Color")
        ;preset("CP - Faded Lumetri Color")
        return
    }
    If ErrorLevel = EndKey:F5
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }
        addEffectToAdjustmentLayer("CP - Red")
        ;preset("CP - Red")
        return
    }
    If ErrorLevel = EndKey:F6
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }
        addEffectToAdjustmentLayer("CP - Blue")
        ;preset("CP - Blue")
        return
    }
    If ErrorLevel = EndKey:F7
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }      
        addEffectToAdjustmentLayer("CP - Green")  
        ;preset("CP - Green")  
        return
    }
    If ErrorLevel = EndKey:F8
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }
        return
    }
    If ErrorLevel = EndKey:F9
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }
        return
    }
    If ErrorLevel = EndKey:F10
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }
        
        return
    }
    If ErrorLevel = EndKey:F11
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }
        
        return
    }
    If ErrorLevel = EndKey:F12
    {
        If sheet = 1
        {
            ;preset("CP - Deep Contrast")
        }
        If sheet = 2
        {
            ;preset("CP - Fade to D Contrast")
        }
        If sheet = 3
        {

        }
        
        return
    }
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
        return
    }  
    If ErrorLevel = EndKey:F2
    {
        loadSequence("CPSEQ-kiki-wyatt-crazy-look-earrape-laugh")        
        return
    }  
    If ErrorLevel = EndKey:F3
    {
        loadSequence("CPSEQ-its-clobbering-time")
        return
    }    
} 

return

;Close ups
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~9::
{
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    ;Close ups moving L to R    
    ;Close ups moving in and out
    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If ErrorLevel = EndKey:F1
    {
        insertCloseUpAdjustment("CP - Adj Me Zoom 2 Left to Right")
        return
    }    
}    

return

;Close ups moving
#IfWinActive ahk_exe Adobe Premiere Pro.exe
~0::
{
    Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
    ;Close ups moving L to R    
    ;Close ups moving in and out
    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If ErrorLevel = EndKey:F1
    {
        instantVFX()
        ;GetFocusedControl()
        return
    }    
    If ErrorLevel = EndKey:F2
    {
        ;addEffectToAdjustmentLayer("CP - FinOutBnW")
        ;CP - FinOutBnW
        ;CP - FQuickinOutBW
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
}    

return




