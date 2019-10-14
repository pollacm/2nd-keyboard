SetWorkingDir, C:\Users\Owner\source\repos\2nd-keyboard\support_files
;the above will set A_WorkingDir. It must be done in the autoexecute area.
;SetNumLockState, on ;This doesn't work, needs to be done in admin mode.
;SetScrollLockState, off
Menu, Tray, Icon, shell32.dll, 283 ;tray icon is now a little keyboard, or piece of paper or something
;when you get to #include, it means the END of the autoexecute section.
;gui must be #included first, or it does not work, for some reason...
;YOU probably do NOT need the GUI at all. Delete the line below:

global savedCLASS = "ahk_class Notepad++"
global savedEXE = "notepad++.exe" ;BEFORE the #include is apparently the only place these can go.
global globalPosition = "Left"
global secondPosition = "Middle"
global thirdPosition = "Right"

#Include C:\Users\Owner\source\repos\2nd-keyboard\gui.ahk
#include C:\Users\Owner\source\repos\2nd-keyboard\Almost_All_Premiere_Functions.ahk
#include C:\Users\Owner\source\repos\2nd-keyboard\Almost_All_Windows_Functions.ahk
#include C:\Users\Owner\source\repos\2nd-keyboard\After_Effects_Functions.ahk
SetKeyDelay, 0 ;warning ---this was absent for some reason. i just added it back in. IDK if I removed it for a reason or not...

;-------------------------------------------------------------------------
; HELLO PEOPLES 
; CHECK OUT MY BIG TUTORIAL FOR SOME EXPLANATION OF HOW THESE
; AHK SCRIPTS WORK, AND HOW THEY COMMUNICATE WITH ONE ANOTHER.
; https://youtu.be/O6ERELse_QY?t=20m7s
; ;
; IF YOU HAVE NOT USED AHK BEFORE, YOU MUST TAKE THIS TUTORIAL:
;  https://autohotkey.com/docs/Tutorial.htm
;
; IMPORTANT NOTE:
; Using #include is pretty much the same as pasting an entire script into 
; THIS script. So basically, I'm just importing all the functions that I
; have created in those scripts, so that I can refer to them here.
;
; So, this script has all the keyboard assignments, and the other
; #included scripts have all the functions. I had to split it up this way 
; so that I can also directly launch those functions using means OTHER
; than a keyboard, like the Stream Deck's "open file" feature.
;
; ANOTHER NOTE:
; If you have CUE (Corsair Utility Engine) open, and your keyboard selected 
; (in all its RGB glory,) it will take a lot longer to switch between applications. 
; to fix this lag, simply close CUE, or select some other "demo" peripheral.
;------------------------------------------------------------------------
;
;THIS SCRIPT NO LONGER USES LUAMACROS TO REPROGRAM THE SECOND KEYBOARD. IF YOU WANT THAT CODE, PLEASE GO TO "2nd keyboard if using luamacros.ahk"
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; WATCH THESE VIDEOS TO UNDERSTAND YOUR OPTIONS FOR ADDING EXTRA KEYBOARDS:
; https://www.youtube.com/playlist?list=PLH1gH0v9E3ruYrNyRbHhDe6XDfw4sZdZr
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; Lots of other explanatory videos other AHK scripts can be found on my youtube channel! https://www.youtube.com/user/TaranVH/videos 
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

; Also, I will put shortcuts to all the AHK scripts that I use into my startup folder... which is here for all users:
;  C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
;  Or here for just one user:
;  C:\Users\YOUR_USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup


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

;_________________________________________________________________________________________
;                                                                                                                       
; NOTE: In autohotkey, the following special characters (usually) represent modifier keys:
; # is the WIN key. (it can mean other things though, as you can see above.)
; ^ is CTRL
; ! is ALT
; + is SHIFT
; list of other keys: http://www.autohotkey.com/docs/Hotkeys.htm
;__________________________________________________________________________________________
; 
;----------------------------------------------------------------------------------
; RELEVANT SHORTCUTS I HAVE ASSIGNED IN PREMIERE'S BUILT IN KEYBOARD SHORTCUTS MENU
;----------------------------------------------------------------------------------
; KEYS                  PREMIERE FUNCTIONS
;----------------------------------------------------------------------------------
; ctrl alt s            select clip at playhead. Probably this should be moved to a different series of keystrokes, so that "u" is freed for something else.
; backspace             ripple delete --- but I don't use that in AutoHotKey because it's dangerous. This should be changed to something else; I use SHIFT C now.
; shift c               ripple delete --- very convenient for left handed use. Premiere's poor track targeting makes ripple delete less useful than it could be.
; ctrl alt shift d      ripple delete --- I never type this in manually - long shortcuts like this are great for using AHK or a macro to press them.
; delete                delete
; c                     delete --- I also have this on "C" because it puts it directly under my left hand. Very quick.
; ctrl r                speed/duration panel
; shift 1               toggle track targeting for AUDIO LAYER 1
; shift 2               toggle track targeting for AUDIO LAYER 2. And so on up to 8.
; alt 1                 toggle track targeting for VIDEO LAYER 1
; alt 2                 toggle track targeting for VIDEO LAYER 2. And so on up to 8. I wish there were DEDICATED shortcuts to enable and disable ALL layers
; ctrl p                toggle "selection follows playhead"
; ctrl alt shift 3      Application > Window > Timeline (default is shift 3)
; ctrl alt shift 1      Application > Window > Project  (This sets the focus onto a BIN.) (default is SHIFT 1)
; ctrl alt shift 4      Application > Window > program monitor (Default is SHIFT 4)
; ctrl alt shift 7      Application > Window > Effects   (NOT the Effect Controls panel) (Default is SHIFT 7) --- The defaults are stupid. SHIFT 7 is an ampersand if you happen to be in a text box somewhere...
; F2                    gain
; F3                    audio channels --- To be pressed manually by the user. (this might change in the future.)
; ctrl alt shift a      audio channels --- (I will NOT change this, so that it can always be reliably triggered using AutoHotKey.)
; shift F               From source monitor, match frame.
; ctrl /                Overwrite (default is "." (period))
; ctrl b                select find box --- This is such a useful function when you pair it the the effects panel!!
; ctrl alt F            select find box 
; ctrl shift 6			Apply source assignment preset 1 (set to V5 and A3)
; ctrl ; (semicolon)	Add Marker
;                                                                                                                        
; Be aware that sometimes other programs like PUUSH can overlap/conflict with your customized shortcuts.                          
;_______________________________________________________________________________________________
;
;
; NOTE:
; SC0E8: "scan code of an unassigned key" that I use to tell the computer "yeah, treat this like a keyboard,"
; SC0E9: Nullify ALT's sticky key effect. See for more info: Alt_menu_acceleration_DISABLER.ahk
; VK07:  #menumaskkey https://autohotkey.com/docs/commands/_MenuMaskKey.htm



;these are sent from the stream deck.
;I didn't use CTRL and SHIFT and stuff because I wanted NO CROSS TALK!!
;COPY 1 2 and 3
;SC062::ClipBoard_1 := GetFromClipboard() ;zoom
;vk2A::ClipBoard_2 := GetFromClipboard()	 ;Printer
;SC16B::ClipBoard_3 := GetFromClipboard() ;launch (0)

;PASTE 1 2 and 3
;I might have to use proper functions to get these to type faster
;SC16D::SendInput {Raw}%ClipBoard_1%		;launch_media
;vk2B::SendInput {Raw}%ClipBoard_2%		;Execute
;SC121::SendInput %ClipBoard_3% 	;launch (1)

;note to self, this is where to go for tap dance stuff
; https://autohotkey.com/board/topic/35566-rapidhotkey/

currentTool = "v" ;This is super useful and important for a Premiere script, you'll see...

;#if

;this is pause/break. I'm using it for debugging...
;sc045::
;^sc045::
;+sc045::
;!sc045::
;ctrlbreak::
;^ctrlbreak::
;tooltip, pause break
;sleep 100
;tooltip,
;KeyHistory
;sleep 10
;return 
;____________________________________________________________________
;                                                                    
;		  2ND KEYBOARD USING HASU USB TO USB (Logitech K120)  
;____________________________________________________________________
; watch [link NYA] to understand how this works.
; https://www.1upkeyboards.com/shop/controllers/usb-to-usb-converter/

;#if ( \\\\\\\\\\\\\\\getKeyState("F23", "P")) && IfWinActive ahk_exe Adobe Premiere Pro.exe ;have not tested this to see if it works
;#if (getKeyState("F23", "P")) && (uselayer = 0) ;;you can also use a varibable like so.

;#IfWinActive ahk_exe Adobe Premiere Pro.exe
;;;;;;;;;;;;;BEGIN K120 (2ND KEYBOARD) REMAPPED INTO ALL MACRO KEYS;;;;;;;;;;;;;;;;;
;#if (getKeyState("F2")) ;This is the line that makes all the lines below possible. 

;F2::return ;F23 is the dedicated 2nd keyboard "modifier key." You MUST allow it to "return," since it will ALWAYS be fired before any of the keystrokes below, any time you use the 2nd keyboard.
;;This also means that you must NEVER use F23 for anything else. Doing so will sometimes allow a key to pass through unwrapped, which can cause big problems with cross-talk.

;SC06E::return ;;This is F23's scan code. Using this line acts as some more insurance against cross-talk. comment this in if you have issues.



;escape::msgbox,,, you pressed escape. this might cause like problems maybe, 0.9

;F1::return
;F2::insertSFX("Bruh") ;you may not use spaces for filenames of sounds that you want to retreive in this way... since searching in premiere will disregard spaces in a a weird way... returning multiple wrong results....
;F3::insertSFX("Bruh")
;F4::insertSFX("Whoosh2-Short")
;F5::insertSFX("SimpleWhoosh12")
;F6::insertSFX("SimpleWhoosh11")
;F7::insertSFX("SimpleWhoosh10")
;F9::insertSFX("SimpleWhoosh3")
;F8::insertSFX("SimpleWhoosh8")
;F10::insertSFX("woosh2")
;F11::insertSFX("woosh1")
;F12::instantExplorer("N:\Team_Documents\N_TARAN_THINGS\prompter and cutting_room_floor") ;"FLOOR"



;F12::search() ;"search" is also used on ^+j 
; F12 must not used here IF it is the keyboard's launching key. You MAY put it here if you used F13 to F24 as the launching key

;;;;;next line;;;;;;;;
;;;;K120 keyboard;;;;;

;`::msgbox tilde or weird quote thing??
;1::insertSFX("bleep")
;2::
;3::return
;4::
;tooltip, this happens on key down
;keywait, 4 ;waits for the key to go up
;tooltip, and this happens on key up. dang
;return
;5::insertSFX("")
;6::insertSFX("record scratch")
;7::preset("180 hue angle")
;8::preset("PAINT WHITE")
;9::preset("PAINT BLACK")
;0::insertSFX("pop")
;-::audioMonoMaker("left")
;=::audioMonoMaker("right")
;backspace::
;if WinActive("New TightVNC Connection") ;if we are at the thingy that asks for a password or whatever
;	{
;	Sendinput, {enter}
;	goto tvnEND ;LOL ARE YOU TRIGGERED BY THIS!!? DESPAIR!! DESPAIR!!!!
;	}
;IfWinNotExist, ahk_class TvnWindowClass
;	Run, C:\Program Files\TightVNC\tvnviewer.exe
;if WinExist("ahk_exe tvnviewer.exe")
;	WinActivate ahk_exe tvnviewer.exe
;tvnEND:
;all done
;return

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
    If OutputVar = S
    {
        size = S
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If OutputVar = M
    {
        size = M
        Input, OutputVar, L1, {F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}{PrintScreen}
    }
    If OutputVar = L
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
    If ErrorLevel = EndKey:Escape
    {
        return
    }    

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
        If ErrorLevel = En6dKey:F4
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
    ;words 3
    if sheet = 3 
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            insertSFX("goteem")
            return
        }        
    }
    ;effects 1
    if sheet = 4
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
    if sheet = 5
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
            ;insertSFX("correct")
            return
        }
    }
    ;effects 3
    if sheet = 6
    {
        If ErrorLevel = EndKey:Escape
        {
            return
        }
        If ErrorLevel = EndKey:F1
        {
            ;insertSFX("correct")
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
;zelda-secret-1.wav
;zelda-secret-2.wav
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
            insertSFX("zelda-secret-1")
            return
        }
        If ErrorLevel = EndKey:F7
        {
            insertSFX("zelda-secret-2")
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
    Input, OutputVar, L1, 1,2,3,4,5,6,7,8,9,0,{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Escape}
        
    If ErrorLevel = EndKey:Escape
    {
        return
    }
    If ErrorLevel = EndKey:F1
    {
        preset("CP - Mid Contrast")
        return
    }    
    If ErrorLevel = EndKey:F2
    {
        preset("CP - Fade to M Contrast")
        return
    }
    If ErrorLevel = EndKey:F3
    {
        preset("CP - Deep Contrast")
        return
    }
    If ErrorLevel = EndKey:F4
    {
        preset("CP - Fade to D Contrast")
        return
    }
    If ErrorLevel = EndKey:F5
    {
        preset("CP - Black and White")
        return
    }
    If ErrorLevel = EndKey:F6
    {
        preset("CP - Fade to BnW")
        return
    }
    If ErrorLevel = EndKey:F7
    {
        preset("CP - Faded Lumetri Color")
        return
    }
    If ErrorLevel = EndKey:F8
    {
        ;preset("Bruh")
        return
    }
    If ErrorLevel = EndKey:F9
    {
        ;preset("Bruh")
        return
    }
    If ErrorLevel = EndKey:F10
    {
        preset("CP - Blue")
        return
    }
    If ErrorLevel = EndKey:F11
    {
        preset("CP - Green")
        return
    }
    If ErrorLevel = EndKey:F12
    {
        preset("CP - Red")
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
        insertSFX("Bruh")
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
        insertSFX("Bruh")
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
        insertSFX("Bruh")
        return
    }    
}    

return


#IfWinActive ahk_exe Adobe Premiere Pro.exe
;~2::
;global VFXkey = "2"
;preset("CP - Large")
;Send ^!3
;return

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;~3::
;global VFXkey = "3"
;preset("CP - Normal")
;Send ^!2
;return

#IfWinActive ahk_exe Adobe Premiere Pro.exe
;~4::
;global VFXkey = "4"
;preset("CP - XL")
;Send ^!4
;return