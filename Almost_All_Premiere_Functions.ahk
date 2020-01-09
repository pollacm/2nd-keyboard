;C:\Users\Owner\Documents\Adobe\Premiere Pro\13.0\Profile-Owner\Win

;the above will supposedly set A_WorkingDir. It MUST be done in the autoexecute area, BEFORE the code below.
;SetWorkingDir, C:\Users\TaranWORK\Documents\GitHub\2nd-keyboard\2nd keyboard support files

#NoEnv
Menu, Tray, Icon, shell32.dll, 283 ; this changes the tray icon to a little keyboard!
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force ;only one instance of this script may run at a time!
#MaxHotkeysPerInterval 2000
#WinActivateForce ;https://autohotkey.com/docs/commands/_WinActivateForce.htm

;-------------------------------------------------------------------------
; HELLO PEOPLES!
; IF YOU ARE NEW TO AUTOHOTKEY, YOU MUST AT LEAST TAKE THE FOLLOWING TUTORIAL:
; https://autohotkey.com/docs/Tutorial.htm
;
; You will need to know some basic scripting to custom tailor most
; of these scripts to your own machine, if you want to use them!
;
; CHECK OUT MY BIG TUTORIAL FOR SOME EXPLANATION OF HOW THESE
; AHK SCRIPTS WORK, AND HOW THEY COMMUNICATE WITH ONE ANOTHER.
; https://youtu.be/O6ERELse_QY?t=20m7s
;
; VERY IMPORTANT NOTE:
; This file works in tandem with ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk.
; All the functions from HERE are actually CALLED from keyboard shortcuts
; in THAT script. I had to do it this way because of the Stream Deck(s)...
; But you can put your key bindings and functions in the same script if
; you want.
;
; You also need to read from around line 90 of ALL_MULTIPLE_KEYBOARD_ASSIGNMENTS.ahk.
; to see which keybaord shortcut assignements are necessary to make these scripts work.
;
; I reccomend that you only copy the functions that you need.
; Add one at a time or it will be overwhelming!
;
; All the code in my github repo is free for you to use and change as you please.
; Just don't try to sell it, and we cool.
;------------------------------------------------------------------------


;the variable below POSSIBLY exists for the purpose of communicaiton with gui.ahk if a script is launched from the Stream Deck.
TargetScriptTitle = "C:\AHK\2nd-keyboard\gui.ahk ahk_class AutoHotkey"
;but apparently I do not know for sure...

prFocus(panel) ;this function allows you to have ONE spot where you define your personal shortcuts that "focus" panels in premiere.
{
;panel := """" . panel . """" ;this adds quotation marks around the parameter so that it works as a string, not a variable.
; ; ; if (panel = "effect controls")
; ; ; {
	; ; ; Send ^!+5
	; ; ; return
; ; ; }
Send ^!+7 ;bring focus to the effects panel, in order to "clear" the current focus on the MAIN monitor
sleep 12
Send ^!+7 ;do it AGAIN, just in case a panel was full-screened... it would only have exited full screen, and not switched to the effects panel as it should have.
sleep 7
if (panel = "effects")
	goto theEnd ;Send ^!+7 ;do nothing. the shortcut has already been pressed.
else if (panel = "timeline")
	Send +3 ;if focus had already been on the timeline, this would have switched to the next sequence in some arbitrary order.
else if (panel = "program") ;program monitor
	Send ^!+4
else if (panel = "source") ;source monitor
{
	Send ^!+2
	;tippy("send ^!+2")
}
else if (panel = "project") ;AKA a "bin" or "folder"
	Send ^!+1
else if (panel = "effect controls")
	Send +5

theEnd:

}
;end of prFocus()

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;THIS IS A VERY SIMPLE FUNCTION FOR JUST TYPING STUFF INTO THE SEARCH BAR
;but it doesn't apply them to the clips.

effectsPanelType(item := "lol")
{

;Keyshower(item,"effectsPanelType")
; if IsFunc("Keyshower") {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(item,"effectsPanelType") 
	; }


;prFocus("effects") ;reliably brings focus to the effects panel
Send ^+!7 ;CTRL SHIFT ALT 7 -- set in premiere to "effects" panel
sleep 20
Send ^b ;CTRL B --set in premiere to "select find box." Makes a windows noise if you do it again.
sleep 20
Send +{backspace} ;shift backspace deletes any text that may be present.
Sleep, 10
Send %item%
;now this next part re-selects the field in case you want to type anything different
sleep 10
send ^!b ;ctrl alt B is ALSO select find box, but doesn't have the annoying windows sound.
}

;;;;;;;;;;FUNCTION FOR DIRECTLY APPLYING A PRESET EFFECT TO A CLIP!;;;;;;;;;;;;
; preset() is my most used, and most useful AHK function! There is no good reason why Premiere doesn't have this functionality.
;keep in mind, I use 150% UI scaling, so your pixel distances for commands like mousemove WILL be different!
;to use this script yourself, carefully go through  testing the script and changing the values, ensuring that the script works, one line at a time. use message boxes to check on variables and see where the cursor is. remove those message boxes later when you have it all working!
#IfWinActive ahk_exe Adobe Premiere Pro.exe
preset(item)
{
;deselect everything
Send ^+a
sleep 50
;Keyshower(item,"preset") ;YOU DO NOT NEED THIS LINE. -- it simply displays keystrokes on the screen for the sake of tutorials...
if IsFunc("Keyshower")
	{
	Func := Func("Keyshower")
	RetVal := Func.Call(item,"preset") 
	}

ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto theEnding ;and this line is here just in case the function is called while not inside premiere.


;Setting the coordinate mode is really important. This ensures that pixel distances are consistant for everything, everywhere.
coordmode, pixel, Window
coordmode, mouse, Window
coordmode, Caret, Window

;This (temporarily) blocks the mouse and keyboard from sending any information, which could interfere with the funcitoning of the script.
;BlockInput, SendAndMouse
;BlockInput, MouseMove
;BlockInput, On

SetKeyDelay, 0 ;NO DELAY BETWEEN TYPED STUFF! It might actually be best to put this at "1" though.

;prFocus("timeline") ;maybe not essential i think...
Sendinput, ^!+k ;shuttle STOP
sleep 10
Sendinput, ^!+k ; another shortcut for Shuttle Stop. CTRL ALT SHIFT K. Set this in Premiere's shortcuts panel.
;so if the video is playing, this will stop it. Othewise, it can mess up the script.
sleep 5

;msgbox, ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
;;to check if there are lingering variables...

MouseGetPos, xposP, yposP ;------------------stores the cursor's current coordinates at X%xposP% Y%yposP%
sendinput, {mButton} ;this will MIDDLE CLICK to bring focus to the panel underneath the cursor (the timeline). I forget exactly why, but if you create a nest, and immediately try to apply a preset to it, it doesn't work, because the timeline wasn't in focus...?
;but i just tried that and it still didn't work...
sleep 5

prFocus("effects") ;brings focus to the effects panel
;Alternative -->;;Send ^+!7 ;CTRL SHIFT ALT 7 --- you must set this in premiere's keyboard shortcuts menu to the "effects" panel

sleep 15 ;"sleep" means the script will wait for 20 milliseconds before the next command. This is done to give Premiere some time to load its own things.
Sendinput, ^b ;CTRL B ------------------------- set in premiere to "select find box"
sleep 5
;Send ^b ;again... actually this will create the DOODLEDE DOOO noise if you do it twice.


;Any text in the Effects panel's find box has now been highlighted. There is also a blinking "text insertion point" at the end of that text. This is the vertical blinking line, or "caret."  
if (A_CaretX = "")
{
;No Caret (blinking vertical line) can be found.
waiting2 = 0
;the following loop is waiting until it sees the caret. SUPER IMPORTANT. Without this, the function doesn't work 10% of the time.
;This is also way better than just always waiting 60 milliseconds like it had been before. The function can continue as soon as Premiere is ready.
loop
	{
	waiting2 ++
	sleep 33
	tooltip, counter = (%waiting2% * 33)`nCaret = %A_CaretX%
	if (A_CaretX <> "")
		{
		tooltip, CARET WAS FOUND
		break
		}
	if (waiting2 > 30)
		{
		msgbox, FAIL - no caret found
		;Note to self, need much better way to debug this than screwing the user
		sleep 200
		;tooltip,
		GOTO theEnding
		;lol, are you triggered by this GOTO? lolol lololol
		}
	}
sleep 1
tooltip,
}

;yeah, I've seen this go all the way up to "8," which is 264 milliseconds

MouseMove, %A_CaretX%, %A_CaretY%, 0
sleep 5

;;;and fortunately, AHK knows the exact X and Y position of this caret. So therefore, we can find the effects panel find box, no matter what monitor it is on, with 100% consistency!

;tooltip, 1 - mouse should be on the caret X= %A_CaretX% Y= %A_CaretY% now ;;this was super helpful in me solving this one!

;;;msgbox, carat X Y is %A_CaretX%, %A_CaretY%
MouseGetPos, , , Window, classNN
WinGetClass, class, ahk_id %Window%
;tooltip, 2 - ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
;sleep 10 ;do i need this??
;;;I think ControlGetPos is not affected by coordmode??  Or at least, it gave me the wrong coordinates if premiere is not fullscreened... https://autohotkey.com/docs/commands/ControlGetPos.htm 
ControlGetPos, XX, YY, Width, Height, %classNN%, ahk_class %class%, SubWindow, SubWindow ;-I tried to exclude subwindows but I don't think it works...?
;;my results:  59, 1229, 252, 21,      Edit1,    ahk_class Premiere Pro

;tooltip, classNN = %classNN%
;sleep 50
;now we have found a lot of useful information about this find box. Turns out, we don't need most of it...
;we just need the X and Y coordinates of the "upper left" corner...

;comment in the following line to get a message box of your current variable values. The script will not advance until you dismiss the message box.
;MsgBox, xx=%XX% yy=%YY%

MouseMove, XX-15, YY+10, 0 ;--------------------for 100% UI scaling, this moves the cursor onto the magnifying glass
;MouseMove, XX-25, YY+10, 0 ;--------------------for 150% UI scaling, this moves the cursor onto the magnifying glass
;msgbox, should be in the center of the magnifying glass now.
sleep 5 ;was sleep 50
;This types in the text you wanted to search for. Like "pop in." We can do this because the entire find box text was already selected by Premiere. Otherwise, we could click the magnifying glass if we wanted to , in order to select that find box.
Send %item%

sleep 5

if workPC = No 
{
	MouseMove, -80, 72, 0, R ;----------------------(for 100% UI) 	
}
if workPC = Yes
{
	MouseMove, 50, 105, 0, R ;----------------------(for 150% UI) relative to the position of the magnifying glass (established earlier,) this moves the cursor down and directly onto the preset's icon. In my case, it is inside the "presets" folder, then inside of another folder, and the written name should be completely unique so that it is the first and only item.	
}

;msgbox, The cursor should be directly on top of the preset's icon. `n If not, the script needs modification.
sleep 5
MouseGetPos, iconX, iconY, Window, classNN ;---now we have to figure out the ahk_class of the current panel we are on. It used to be DroverLord - Window Class14, but the number changes anytime you move panels around... so i must always obtain the information anew.
;msgbox, %classNN%
sleep 5
WinGetClass, class, ahk_id %Window% ;----------"ahk_id %Window%" is important for SOME REASON. if you delete it, this doesn't work.
;tooltip, ahk_class =   %class% `nClassNN =     %classNN% `nTitle= %Window%
;sleep 50
ControlGetPos, xxx, yyy, www, hhh, %classNN%, ahk_class %class%, SubWindow, SubWindow ;-I tried to exclude subwindows but I don't think it works...?
MouseMove, www/4, hhh/2, 0, R ;-----------------moves to roughly the CENTER of the Effects panel. This clears the displayed presets from any duplication errors. VERY important. without this, the script fails 20% of the time. This is also where the script can go wrong, by trying to do this on the timeline, meaning it didn't get the Effects panel window information as it should have... IDK how to fix yet.
sleep 5
MouseClick, left, , , 1 ;-----------------------the actual click
sleep 5
MouseMove, iconX, iconY, 0 ;--------------------moves cursor BACK onto the effect's icon
;tooltip, should be back on the effect's icon
;sleep 50
sleep 5
MouseClickDrag, Left, , , %xposP%, %yposP%, 0 ;---clicks the left button down, drags this effect to the cursor's pervious coordinates and releases the left mouse button, which should be above a clip, on the TIMELINE panel.

sleep 5
;prFocus("effects")
;sleep 15
;Sendinput, ^b ;CTRL B ------------------------- set in premiere to "select find box"
;sleep 15
;Send {Del} ;clear effects panel
;sleep, 15

MouseClick, middle, , , 1 ;this returns focus to the panel the cursor is hovering above, WITHOUT selecting anything. great!
;blockinput, MouseMoveOff ;returning mouse movement ability
;BlockInput, off ;do not comment out or delete this line -- or you won't regain control of the keyboard!! However, CTRL+ALT+DEL will still work if you get stuck!! Cool.

;remove the following thingy if it makes no sense to you
IfInString, item, CROP
{
	if IsFunc("cropClick") {
		Func := Func("cropClick")
		sleep 160 ;because it might take awhile to appear in Premiere
		sleep 160 ;because it might take awhile to appear in Premiere
		RetVal := Func.Call() 
		}
	; sleep 160
	; cropClick()
	; ;msgbox, that had "CROP" in it.
}
;remove the above thingy if it makes no sense to you

theEnding:
}
;END of preset()


;savepreset(presetname){
;SendInput, {Shift Down}{Shift Up}{Ctrl Down}{c Down}
;sleep 20
;SendInput, {c up}{Ctrl up}
;sleep 20
;msgbox, text in clipboard = %clipboard%
;presetname = %clipboard%
;msgbox, presetname = %presetname%
;return presetname
;}


#IfWinActive ahk_exe Adobe Premiere Pro.exe
insertSFX(leSound, layerToInsertOn:=1, overwrite:=1)
{
	
ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto sfxEnding 
;keyShower(leSound, "insertSFX")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(leSound, "insertSFX") 
}
CoordMode, mouse, Screen
CoordMode, pixel, Screen
coordmode, Caret, screen

BlockInput, mouse
blockinput, MouseMove
BlockInput, On
SetKeyDelay, 0 ;for instant writing of text
MouseGetPos, xpos, ypos
send ^+x ;ctrl shift x -- shortcut in premiere for "remove in/out points.
sleep 10
if(layerToInsertOn = 1)
{
	send ^+9 ;ctrl shift 9 - source assignment preset 4. (sets it to A3.)
}
if(layerToInsertOn = 2)
{
	send ^+8 ;ctrl shift 8 - source assignment preset 5. (sets it to A2/V1.)
}
if(layerToInsertOn = 3)
{
	send ^+7 ;ctrl shift 7 - source assignment preset 6. (sets it to A4/V4.)
}
if(layerToInsertOn = 4)
{
	send ^+6 ;ctrl shift 6 - source assignment preset 7. (sets it to A5/V5.)
}

sleep 10
; Send ^!+1 ;premiere shortcut to open the "project" panel, which is actually a bin. Only ONE bin is highlightable in this way.
; ;Send F11
; sleep 100
;msgbox, you in the panel now?

send ^!+1 ;CTRL ALT SHIFT 1 -- ;shortcut for application>window>project (highlights a single bin. In my case, it's on my left monitor.)
tooltip, waiting for premiere to select that bin....
;msgbox, waiting for premiere to select that bin....
sleep 20
;msgbox how about naow?
; 
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box." Make sure there are NO OTHER conflicting shortcuts on this key, like "create new bin," which would stop it from working.
; send +{backspace} ;to delete anything that might be written in the bin, so that the caret coordinates are always accurate.

; msgbox, okay now what
Send %leSound% ;types in the name of the sound effect you want - should do so instantaneously.
tooltip, waiting for premiere to load......
if(layerToInsertOn = 1)
{
	send ^+9 ;source assignment preset 4, again.
}
if(layerToInsertOn = 2)
{
	send ^+8 ;source assignment preset 5, again.
}
if(layerToInsertOn = 3)
{
	send ^+7 ;source assignment preset 6, again.
}
if(layerToInsertOn = 4)
{
	send ^+6 ;ctrl shift 6 - source assignment preset 7. (sets it to A5/V5.)
}

sleep 400 ;we are waiting for the search to complete....
;sleep 400 ;we are still waiting for the search to complete....
;msgbox, wheres de mouse?
;MouseMove, -6000, 250, 0 ;moves the mouse to the expected location of the bin that becomes highlighted from the "project" keyboard shortcut command in Premiere.

if(workPC = "No")
{
	MouseMove, 35, 229, 0 ;moves the mouse to the expected location of the bin that becomes highlighted from the "project" keyboard shortcut command in Premiere.	
}
if(workPC = "Yes")
{
	MouseMove, 80, 300, 0 ;moves the mouse to the expected location of the bin that becomes highlighted from the "project" keyboard shortcut command in Premiere.	
}

;msgbox, wheres de mouse?
; MouseGetPos, lol, lel
; PixelGetColor, zecolor, lol, lel, alt slow rgb
; msgbox, %zecolor% 
MouseClick, left
tooltip, CLICK!!!
sleep 50
if(layerToInsertOn = 1)
{
	send ^+9 ;source assignment preset 4, again.
}
if(layerToInsertOn = 2)
{
	send ^+8 ;source assignment preset 5, again.
}
if(layerToInsertOn = 3)
{
	send ^+7 ;source assignment preset 6, again.
}
if(layerToInsertOn = 4)
{
	send ^+6 ;ctrl shift 6 - source assignment preset 7. (sets it to A5/V5.)
}
sleep 5
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box."
sleep 10
Send +{backspace} ;deletes the search text so that the bin returns to normal view with all SFX visible.
sleep 10
MouseMove, %xpos%, %ypos%, 0 ;move mouse back to original coordinates.

sleep 20
tooltip, so did that work?
;msgbox, clicked, mouse should be back at original coordinates.

;send ^!+4 ;select program monitor
sleep 10
;send ^!+3 ;select timeline
sleep 10
if(layerToInsertOn = 1)
{
	send ^+9 ;my shortcut for "assign source assignment preset 4" in Premiere. The preset has A4 selected as sources. I may end up only using F18, since it does not use the CTRL and SHIFT keys, which can cause problems sometimes.
}
if(layerToInsertOn = 2)
{
	send ^+8 ;my shortcut for "assign source assignment preset 5" in Premiere. The preset has V1 and A2 selected as sources. I may end up only using F18, since it does not use the CTRL and SHIFT keys, which can cause problems sometimes.
}
if(layerToInsertOn = 3)
{
	send ^+7 ;my shortcut for "assign source assignment preset 6" in Premiere. The preset has V4 and A4 selected as sources. I may end up only using F18, since it does not use the CTRL and SHIFT keys, which can cause problems sometimes.
}
if(layerToInsertOn = 4)
{
	send ^+6 ;ctrl shift 6 - source assignment preset 7. (sets it to A5/V5.)
}

sleep 50
Send ^/ ;CTRL FORWARD SLASH -- SET TO "OVERWRITE" in premiere. Premiere's default shortcut for "overwrite" is a period.  I use modifier keys for THIS, so that a period is never typed accidentally.
sleep 30
; Send mbutton ;this will MIDDLE CLICK to reselect whatever panel your cursor was hovering over before you engaged this function.
send ^!+7 ;highlight effects panel
sleep 30
send ^!+3 ;this is set in premiere to highlight/switch to the timeline. important so that you aren't still stuck in the bin. If this is used more than once, it will unfortunately cycle thorugh all available sequences...
tooltip,
send +3
BlockInput, off
BlockInput, MouseMoveOff
sfxEnding:
}
;;end of insertSFX()


;capture screenshot
#IfWinActive ahk_exe Adobe Premiere Pro.exe
captureScreenshot()
{
	
ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto captureScreenshotEnding 
;keyShower("captureScreenshot")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call("captureScreenshot") 
}

Send ^!+3 ;highlight timeline
sleep 30
MouseGetPos, xpos, ypos
sleep 30
send ^+8 ;ctrl shift 8 - source assignment preset 5. (sets it to A2/V1.)
sleep 30
Send ^+e ;shortcut to take screenshot
sleep 30

Input, OutputVar, L1, {Escape}
while (OutputVar != 1)
{
	If ErrorLevel = EndKey:Escape
	{
		return
	}
	Send %OutputVar%
	Input, OutputVar, L1, {Escape}
	If ErrorLevel = EndKey:Escape
	{
		return
	}
}
sleep 30
Send ^a
sleep 30
Send ^c
sleep 30
Send {Enter}
sleep 100
Send ^+!1
sleep 10
Send ^+!1
Send ^b ;expand searchbar
Send ^v ;paste
sleep 50
SendInput, .png

Input, OutputVar, L1, {Escape}
If ErrorLevel = EndKey:Escape
{
	return
}
MouseClick, left
sleep 50
send ^+8 ;ctrl shift 8 - source assignment preset 5. (sets it to A2/V1.)
sleep 50
if overwrite = 1
{
	Send ^/ ;CTRL FORWARD SLASH -- SET TO "OVERWRITE" in premiere. Premiere's default shortcut for "overwrite" is a period.  I use modifier keys for THIS, so that a period is never typed accidentally.
}
else
{
	Send ^\
}

sleep 30
MouseMove, xpos, ypos, 0 ;--------------------moves cursor BACK

captureScreenshotEnding:
}
;;end of captureScreenshot()




;insert double preset
#IfWinActive ahk_exe Adobe Premiere Pro.exe
insertDoublePreset(topItem, bottomItem)
{
	
ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto insertDoublePresetEnding 
;keyShower(topItem, bottomItem, "insertDoublePreset")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(topItem, bottomItem, "insertDoublePreset") 
}

preset(topItem)

Input, OutputVar, L1, {Escape}
If ErrorLevel = EndKey:Escape
{
	return
}
preset(bottomItem)

insertDoublePresetEnding:
}
;;end of insertDoublePreset()


























#IfWinActive ahk_exe Adobe Premiere Pro.exe
insertCloseUpAdjustment(item)
{
	
ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto insertCloseUpAdjustmentEnding 
;keyShower(item, "insertCloseUpAdjustmentEnding")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(item, "insertCloseUpAdjustment") 
}

Send f
sleep 10
send !{UP}
sleep 10
;send {DOWN}
;sleep 10
;send {UP}
;sleep 10
insertSFX("13335", 2)
sleep 10
Input, OutputVar, L1, {Escape}
If ErrorLevel = EndKey:Escape
{
	return
}
preset("CP - Base Zoom Close Up Me")

Input, OutputVar, L1, {Escape}
If ErrorLevel = EndKey:Escape
{
	return
}
preset("CP - Base Zoom Close Up Background")

sleep 50
insertSFX("Me-Overlay-Adjustment-Layer", 3)

sleep 10
Input, OutputVar, L1, {Escape}
If ErrorLevel = EndKey:Escape
{
	return
}
preset(item)

insertCloseUpAdjustmentEnding:
}
;;end of insertCloseUpAdjustment()

#IfWinActive ahk_exe Adobe Premiere Pro.exe
insertAudio(leSound)
{
	
ifWinNotActive ahk_exe Adobe Premiere Pro.exe
	goto audioEnding 
;keyShower(leSound, "insertSFX")
if IsFunc("Keyshower") {
	Func := Func("Keyshower")
	RetVal := Func.Call(leSound, "insertAudio") 
}
CoordMode, mouse, Screen
CoordMode, pixel, Screen
coordmode, Caret, screen

BlockInput, mouse
blockinput, MouseMove
BlockInput, On
SetKeyDelay, 0 ;for instant writing of text
MouseGetPos, xpos, ypos
send ^+x ;ctrl shift x -- shortcut in premiere for "remove in/out points.
sleep 10
send ^+9 ;ctrl shift 6 - source assignment preset 4. (sets it to A3.)
sleep 10
; Send ^!+1 ;premiere shortcut to open the "project" panel, which is actually a bin. Only ONE bin is highlightable in this way.
; ;Send F11
; sleep 100
;msgbox, you in the panel now?
send ^!+1 ;CTRL ALT SHIFT 1 -- ;shortcut for application>window>project (highlights a single bin. In my case, it's on my left monitor.)
tooltip, waiting for premiere to select that bin....
;msgbox, waiting for premiere to select that bin....
sleep 20
;msgbox how about naow?
; 
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box." Make sure there are NO OTHER conflicting shortcuts on this key, like "create new bin," which would stop it from working.
; send +{backspace} ;to delete anything that might be written in the bin, so that the caret coordinates are always accurate.

; msgbox, okay now what
Send %leSound% ;types in the name of the sound effect you want - should do so instantaneously.
tooltip, waiting for premiere to load......
send ^+9 ;source assignment preset 4, again.
sleep 400 ;we are waiting for the search to complete....
;sleep 400 ;we are still waiting for the search to complete....
;msgbox, wheres de mouse?
;MouseMove, -6000, 250, 0 ;moves the mouse to the expected location of the bin that becomes highlighted from the "project" keyboard shortcut command in Premiere.
if(workPC = "No")
{
	MouseMove, 35, 229, 0 ;moves the mouse to the expected location of the bin that becomes highlighted from the "project" keyboard shortcut command in Premiere.	
}
if(workPC = "Yes")
{
	MouseMove, 80, 300, 0 ;moves the mouse to the expected location of the bin that becomes highlighted from the "project" keyboard shortcut command in Premiere.	
}
;msgbox, wheres de mouse?
; MouseGetPos, lol, lel
; PixelGetColor, zecolor, lol, lel, alt slow rgb
; msgbox, %zecolor% 
MouseClick, left
sleep 10
MouseClick, left
sleep 100
Send {Home}
Send i
sleep 100
Send {Right}
Send {Right}
Send {Right}
Send {Right}
Send {Right}
Send {Right}
Send {Right}
Send {Right}
Send {Right}
Send {Right}
sleep 100
Send o
sleep 10
send ^+9 ;source assignment preset 4, again.
Send ^/ 
sleep 5
send ^!+1
sleep 10
Send ^b ;CTRL B -- set this in premiere's shortcuts panel to "select find box."
sleep 10
Send +{backspace} ;deletes the search text so that the bin returns to normal view with all SFX visible.
sleep 10
MouseMove, %xpos%, %ypos%, 0 ;move mouse back to original coordinates.
sleep 20
tooltip, so did that work?
send ^!+7 ;highlight effects panel
sleep 30
send ^!+3 ;this is set in premiere to highlight/switch to the timeline. important so that you aren't still stuck in the bin. If this is used more than once, it will unfortunately cycle thorugh all available sequences...
tooltip,
send +3
BlockInput, off
BlockInput, MouseMoveOff
audioEnding:
}
;;end of audioEnding()

#ifwinactive

marker(){
sendinput, ^!+K ;Premiere shortcut for STOP
sleep 5
send ^{SC027} ;this is the scan code for a semicolon. CTRL SEMICOLON is one of my shortcuts to create a marker.  ^;  You have to set that up in Premiere of course.

}

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;THIS IS A VERY SIMPLE FUNCTION FOR JUST TYPING STUFF INTO THE SEARCH BAR
;but it doesn't apply them to the clips.

;effectsPanelType(item := "lol")
;{

;Keyshower(item,"effectsPanelType")
; if IsFunc("Keyshower") {
	; Func := Func("Keyshower")
	; RetVal := Func.Call(item,"effectsPanelType") 
	; }


;prFocus("effects") ;reliably brings focus to the effects panel
;Send ^+!7 ;CTRL SHIFT ALT 7 -- set in premiere to "effects" panel
;sleep 20
;Send ^b ;CTRL B --set in premiere to "select find box." Makes a windows noise if you do it again.
;sleep 20
;Send +{backspace} ;shift backspace deletes any text that may be present.
;Sleep, 10
;Send %item%
;now this next part re-selects the field in case you want to type anything different
;sleep 10
;send ^!b ;ctrl alt B is ALSO select find box, but doesn't have the annoying windows sound.
;}

addEffectToAdjustmentLayer(effect)
{
	insertSFX("adjustment-layer", 3)

	Input, OutputVar, L1, {Escape}
	If ErrorLevel = EndKey:Escape
	{
		return
	}
	preset(effect)
}

loadSequence(sequenceName)
{
	prFocus("project")
	sleep 10
	Send ^!+1 ;need to do it twice to get to the right bin
	sleep 10

	send ^b
	sleep 30
	SendInput %sequenceName%
	
	sleep 300
	Send {Tab}

	sleep 10
	Send {Enter}

	sleep 300
	Send ^+4 ; open sequence ctrl/shift 4

	sleep 500
	Send ^a

	sleep 20
	Send ^c

	sleep 50
	send ^w ;close the window

	sleep 50
	send ^+5 ;paste insert

	sleep 20
	Send ^l ;unlink clip
	
	;cleanup
	prFocus("project")
	sleep 10
	Send ^!+1 ;need to do it twice to get to the right bin
	sleep 10

	send ^b
	sleep 30
	SendInput {BackSpace}
	sleep 10

	Send {Tab}
	sleep 10

	Send {Escape}
	sleep 10

	Send {Up}
	Send {Up}
	Send {Up}
	Send {Up}
	Send {Up}
	
	sleep 10
	prFocus("timeline")
}

;https://www.autohotkey.com/boards/viewtopic.php?t=23987
instantVFX()
{
	; blockinput, sendandMouse
	; blockinput, MouseMove
	; blockinput, on
	;-Sendinput ^!+5
	
	prFocus("effect controls") ;essentially just hits CTRL ALT SHIFT 5 to highlight the effect controls panel.
	sleep 10
	;ToolTip, A, , , 2
	MouseGetPos currentMouseX, currentMouseY

	if workPC = Yes
	{
		ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class65, ahk_class Premiere Pro ;This is HOPEFULLY the ClassNN of the effect controls panel. Use Window Spy to figure it out.
	}
	else if workPC = No
	{
		ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class60, ahk_class Premiere Pro ;This is HOPEFULLY the ClassNN of the effect controls panel. Use Window Spy to figure it out.
	}	
	
	;msgbox, %Xcorner% %Ycorner% %Width% %Height%

	sleep 10	
	MouseMove, Xcorner, Ycorner, 0
	MouseClick, left, , , 1
	sleep 10

	if workPC = Yes
	{
		YY := Ycorner+200 ;ui 100%
		XX := Xcorner+175 ;ui 100%

		;YY := Ycorner+3000 ;ui 100%
		;XX := Xcorner+3000 ;ui 100%
	}
	else if workPC = No
	{
		YY := Ycorner+125 ;ui 100%
		XX := Xcorner+115 ;ui 100%
	}	
	
	sleep 10
	Send {Home}

	; MouseMove, Xcorner, Ycorner, 0
	; msgbox, mouse is here

	; MouseMove, XX, YY, 0
	; msgbox, mouse is here now

	if workPC = Yes
	{
		fileName = motion-up-small-w.PNG
		ImageSearch, FoundX, FoundY, 0, 0, XX, YY, %workingDir%\%fileName%
	}
	else if workPC = No
	{
		fileName = motion-up-small.PNG
		ImageSearch, FoundX, FoundY, Xcorner, Ycorner, XX, YY, %workingDir%\%fileName%
	}
	
	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019_ui100.png
		;msgbox, lvl1 %workingDir%\%fileName%
	}
	else if ErrorLevel = 2
	{
		;msgbox,,, ERROR LEVEL 2`nCould not conduct the search  %workingDir%\%fileName%,1
		;resetFromAutoVFX()
	}	
	else
	{
		sleep 10
		MouseMove, FoundX, FoundY, 0
		sleep 10
		MouseClick, left, , , 1 ;-----------------------the actual click
		sleep 20
		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		;MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text
		;sleep 5
		;findHotText(foobar)		
	}

	if workPC = Yes
	{
		fileName = motion-down-w.PNG
	}
	else if workPC = No
	{
		fileName = motion-down.PNG
	}
	ImageSearch, motionDownX, motionDownY, Xcorner, Ycorner, XX, YY, %workingDir%\%fileName%
	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019_ui100.png
		;msgbox, lvl1 %workingDir%\%fileName%
	}
	else if ErrorLevel = 2
	{
		msgbox,,, ERROR LEVEL 2`nCould not conduct the search %workingDir%\%fileName%,1
		;resetFromAutoVFX()
	}	
	else
	{
		sleep 10
		motionDownX := motionDownX + 50
		;MouseMove, motionDownX, motionDownY, 0
		sleep 10
		;MouseClick, left, , , 1 ;-----------------------the actual click
		;sleep 20
		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		;MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text
		;sleep 5
		;findHotText(foobar)
	}	
	
	if workPC = Yes
	{
		fileName = scale-keyframe-on-w.PNG
	}
	else if workPC = No
	{
		fileName = scale-keyframe-on.PNG
	}
	ImageSearch, FoundX, FoundY, Xcorner, Ycorner, XX, YY, %workingDir%\%fileName%
	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019_ui100.png
		; msgbox, scale on lvl1 %workingDir%\%fileName%
		; MouseMove, Xcorner, Ycorner, 0
		; msgbox, xcorner ycorner

		; MouseMove, XX, YY, 0
		; msgbox, XX, YY
	}
	else if ErrorLevel = 2
	{
		;msgbox,,, scale on ERROR LEVEL 2`nCould not conduct the search %workingDir%\%fileName%,1
		;resetFromAutoVFX()
	}	
	else
	{
		sleep 10
		MouseMove, FoundX, FoundY, 0
		sleep 10
		MouseClick, left, , , 1 ;-----------------------the actual click
		sleep 10		
		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The scale on icon was found at %FoundX%x%FoundY%.
		;MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text
		;sleep 5
		;findHotText(foobar)		
	}

	if workPC = Yes
	{
		fileName = scale-keyframe-off-w.PNG
	}
	else if workPC = No
	{
		fileName = scale-keyframe-off.PNG
	}
	ImageSearch, FoundX, FoundY, Xcorner, Ycorner, XX, YY, %workingDir%\%fileName%
	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019_ui100.png
		;msgbox, scale off lvl1 %workingDir%\%fileName%
	}
	else if ErrorLevel = 2
	{
		;msgbox,,, scale off ERROR LEVEL 2`nCould not conduct the search %workingDir%\%fileName%,1
		;resetFromAutoVFX()
	}	
	else
	{
		sleep 10
		MouseMove, FoundX, FoundY, 0
		sleep 10
		MouseClick, left, , , 1 ;-----------------------the actual click
		sleep 10		
		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The scale off icon was found at %FoundX%x%FoundY%.
		;MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text
		;sleep 5
		;findHotText(foobar)
	}

	scaleSearchLeftX := FoundX
	scaleSearchRightX := FoundX+Width

	scaleSearchTopY := FoundY-10
	scaleSearchBottomY := FoundY+15
	sleep 75

	; MouseMove, scaleSearchLeftX, scaleSearchTopY, 0
	; msgbox, first area

	; MouseMove, scaleSearchRightX, scaleSearchBottomY, 0
	; msgbox, second area

	if workPC = Yes
	{
		fileName = keyframe-on-w.PNG
	}
	else if workPC = No
	{
		fileName = keyframe-on.PNG
	}
	ImageSearch, scaleKeyFrameX, scaleKeyFrameY, scaleSearchLeftX, scaleSearchTopY, scaleSearchRightX, scaleSearchBottomY, %A_WorkingDir%\%fileName%
	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019_ui100.png
		;msgbox, lvl1 %workingDir%\%fileName%
	}
	else if ErrorLevel = 2
	{
		;msgbox,,, ERROR LEVEL 2`nCould not conduct the search %workingDir%\%fileName%,1
		;resetFromAutoVFX()
	}	
	else
	{
		sleep 10
		MouseMove, scaleKeyFrameX, scaleKeyFrameY, 0
		sleep 10
		;MouseClick, left, , , 1 ;-----------------------the actual click

		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		;MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text
		;sleep 5
		;findHotText(foobar)
	}

	if workPC = Yes
	{
		fileName = position-keyframe-on-w.PNG
	}
	else if workPC = No
	{
		fileName = position-keyframe-on.PNG
	}
	ImageSearch, FoundX, FoundY, Xcorner, Ycorner, XX, YY, %workingDir%\%fileName%
	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019_ui100.png
		;msgbox, lvl1 %workingDir%\%fileName%
	}
	else if ErrorLevel = 2
	{
		;msgbox,,, ERROR LEVEL 2`nCould not conduct the search %workingDir%\%fileName%,1
		;resetFromAutoVFX()
	}	
	else
	{
		sleep 10
		MouseMove, FoundX, FoundY, 0
		sleep 10
		MouseClick, left, , , 1 ;-----------------------the actual click
		sleep 10		
		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		;MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text
		;sleep 5
		;findHotText(foobar)
	}

	if workPC = Yes
	{
		fileName = position-keyframe-off-w.PNG
	}
	else if workPC = No
	{
		fileName = position-keyframe-off.PNG
	}
	ImageSearch, FoundX, FoundY, Xcorner, Ycorner, XX, YY, %workingDir%\%fileName%
	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019_ui100.png
		;msgbox, lvl1 %workingDir%\%fileName%
	}
	else if ErrorLevel = 2
	{
		;msgbox,,, ERROR LEVEL 2`nCould not conduct the search %workingDir%\%fileName%,1
		;resetFromAutoVFX()
	}	
	else
	{
		sleep 10
		MouseMove, FoundX, FoundY, 0
		sleep 10
		MouseClick, left, , , 1 ;-----------------------the actual click
		sleep 10		
		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		;MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text
		;sleep 5
		;findHotText(foobar)
	}

	positionSearchLeftX := FoundX
	positionSearchRightX := FoundX+Width

	positionSearchTopY := FoundY-10
	positionSearchBottomY := FoundY+15
	sleep 75

	; MouseMove, positionSearchLeftX, positionSearchTopY, 0
	; msgbox, first area

	; MouseMove, positionSearchRightX, positionSearchBottomY, 0
	; msgbox, second area

	if workPC = Yes
	{
		fileName = keyframe-on-w.PNG
	}
	else if workPC = No
	{
		fileName = keyframe-on.PNG
	}
	ImageSearch, positionKeyFrameX, positionKeyFrameY, positionSearchLeftX, positionSearchTopY, positionSearchRightX, positionSearchBottomY, %A_WorkingDir%\%fileName%
	if ErrorLevel = 1
	{
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
		;msgbox, whwhwuhuat
		;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %workingDir%\%foobar%_D2019_ui100.png
		;msgbox, lvl1 %workingDir%\%fileName%
	}
	else if ErrorLevel = 2
	{
		;msgbox,,, ERROR LEVEL 2`nCould not conduct the search %workingDir%\%fileName%,1
		;resetFromAutoVFX()
	}	
	else
	{
		sleep 10
		MouseMove, positionKeyFrameX, positionKeyFrameY, 0
		sleep 10
		;MouseClick, left, , , 1 ;-----------------------the actual click

		;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
		;msgbox, The icon was found at %FoundX%x%FoundY%.
		;MouseMove, FoundX, FoundY, 0
		;msgbox,,,moved to located text
		;sleep 5
		;findHotText(foobar)
	}

	sleep 100

	; Send, {End}
	; sleep 10
	; MouseMove, positionKeyFrameX, positionKeyFrameY, 0
	; sleep 10
	; MouseClick, left, , , 1 ;-----------------------the actual click

	; sleep 10
	; MouseMove, scaleKeyFrameX, scaleKeyFrameY, 0
	; sleep 10
	; MouseClick, left, , , 1 ;-----------------------the actual click

	; sleep 10
	; Send, {Home}
	; sleep 10
	
	prFocus("effect controls")
	sleep 10
	originalClipboard := ClipboardAll
;	msgbox, %originalClipboard%
	clipboard := ""   ; Empty the clipboard.
	Send, {Tab}
	sleep 10
	Send, ^c
	ClipWait
	currentSetPositionX := clipboard

	sleep 10
	clipboard := ""   ; Empty the clipboard.
	Send, {Tab}
	sleep 10
	Send, ^c
	ClipWait
	currentSetPositionY := clipboard
	
	sleep 10
	clipboard := ""   ; Empty the clipboard.
	Send, {Tab}
	sleep 10
	Send, ^c
	ClipWait
	currentSetScale := clipboard

	Clipboard := originalClipboard
;	msgbox, Clipboard
	;msgbox, %Clipboard%
	originalClipboard := ""

	sleep 50
	Send, {Tab}		
	sleep 50	
	Send, {Right}
	Send, {Right}
	Send, {Right}

	sleep 50
	MouseMove, motionDownX, motionDownY, 0
	sleep 50
	MouseClick, left, , , 1 ;-----------------------the actual click	
	sleep 50
	
	Input, OutputVar, L1, {Escape}
	If ErrorLevel = EndKey:Escape
	{
		return
	}
	prFocus("effect controls")
	; sleep 10
	; MouseMove, positionKeyFrameX, positionKeyFrameY, 0
	; sleep 10
	; MouseClick, left, , , 1 ;-----------------------the actual click

	; sleep 10
	; MouseMove, scaleKeyFrameX, scaleKeyFrameY, 0
	; sleep 10
	; MouseClick, left, , , 1 ;-----------------------the actual click
	
	; sleep 10
	Send, {Right}

	sleep 300
	MouseMove, scaleKeyFrameX, scaleKeyFrameY, 0
	sleep 10
	MouseClick, left, , , 1 ;-----------------------the actual click

	sleep 10
	MouseMove, positionKeyFrameX, positionKeyFrameY, 0
	sleep 10
	MouseClick, left, , , 1 ;-----------------------the actual click	

	sleep 10
	Send, {End}
	sleep 10
	Send, {Left}
	Send, {Left}
	Send, {Left}

	sleep 50
	MouseMove, motionDownX, motionDownY, 0
	sleep 50
	MouseClick, left, , , 1 ;-----------------------the actual click	
	sleep 50

	Input, OutputVar, L1, {Escape}
	If ErrorLevel = EndKey:Escape
	{
		return
	}
	prFocus("effect controls")
	; sleep 10
	; MouseMove, positionKeyFrameX, positionKeyFrameY, 0
	; sleep 10
	; MouseClick, left, , , 1 ;-----------------------the actual click

	; sleep 10
	; MouseMove, scaleKeyFrameX, scaleKeyFrameY, 0
	; sleep 10
	; MouseClick, left, , , 1 ;-----------------------the actual click

	; sleep 10
	Send, {Left}
	sleep 300
	MouseMove, scaleKeyFrameX, scaleKeyFrameY, 0
	sleep 10
	MouseClick, left, , , 1 ;-----------------------the actual click

	sleep 10
	MouseMove, positionKeyFrameX, positionKeyFrameY, 0
	sleep 10
	MouseClick, left, , , 1 ;-----------------------the actual click	

	sleep 10
	Send, {End}
	sleep 10

	Send, {Tab}
	sleep 10
	SendInput, %currentSetPositionX%
	sleep 10

	Send, {Tab}
	sleep 10
	SendInput, %currentSetPositionY%
	sleep 10

	Send, {Tab}
	sleep 10
	SendInput, %currentSetScale%
	sleep 10

	Send, {Tab}
	sleep 10
	MouseMove, currentMouseX, currentMouseY, 0

	blockinput, off
	blockinput, MouseMoveOff
}

; instantVFX(foobar)
; {
; dontrestart = 0
; restartPoint:
; blockinput, sendandMouse
; blockinput, MouseMove
; blockinput, on
; ;-Sendinput ^!+5
; prFocus("effect controls") ;essentially just hits CTRL ALT SHIFT 5 to highlight the effect controls panel.
; sleep 10
; ;ToolTip, A, , , 2
; MouseGetPos Xbeginlol, Ybeginlol
; global Xbegin = Xbeginlol
; global Ybegin = Ybeginlol
; ; MsgBox, "please verify that the mouse cannot move"
; ; sleep 2000
; ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;This is HOPEFULLY the ClassNN of the effect controls panel. Use Window Spy to figure it out.
; ;I might need a far more robust way of ensuring the effect controls panel has been located, in the future.

; ;move mouse to expected triangle location. this is a VERY SPECIFIC PIXEL which will be right on the EDGE of the triangle when it is OPEN.
; ;This takes advantage of the anti-aliasing between the color of the triangle, and that of the background behind it.
; ;these pixel numbers will be DIFFERENT depending upon the RESOLUTION and UI SCALING of your monitor(s)
; ; YY := Ycorner+99 ;ui 150%
; ; XX := Xcorner+19 ;ui 150%
; YY := Ycorner+66 ;ui 100%
; XX := Xcorner+13 ;ui 100%

; MouseMove, XX, YY, 0
; sleep 10

; PixelGetColor, colorr, XX, YY

; ; if (colorr = "0x353535") ;for 150% ui
; if (colorr = "0x222222") ;for 100% ui
; {
; 	tooltip, color %colorr% means closed triangle. Will click and then SCALE SEARCH
; 	blockinput, Mouse
; 	Click XX, YY
; 	sleep 5
; 	clickTransformIcon()
; 	findVFX(foobar)
; 	Return
; }
; ;else if (colorr = "0x757575") ;for 150% ui. again, this values could be different for everyone. check with window spy. This color simply needs to be different from the color when the triangle is closed. it also cannot be the same as a normal panel color (1d1d1d or 232323)
; else if (colorr = "0x7A7A7A") ;for 100% ui
; {
; 	;tooltip, %colorr% means OPENED triangle. SEARCHING FOR SCALE
; 	blockinput, Mouse
; 	sleep 5
; 	clickTransformIcon()
; 	findVFX(foobar)
; 	;untwirled = 1
; 	Return, untwirled
; }
; else if (colorr = "0x1D1D1D" || colorr = "0x232323")
; 	{
; 	tooltip, this is a normal panel color of 0x1d1d1d or %colorr%, which means NO CLIP has been selected ; assuming you didnt change your UI brightness. so we are going to select the top clip at playhead.
; 	;I should experiement with putting a "deselect all clips on the timeline" shortcut here...
; 	Send ^p ;--- i have CTRL P set up to toggle "selection follows playhead," which I never use otherwise. ;this makes it so that only the TOP clip is selected.
; 	sleep 10
; 	Send ^p ;this disables "selection follows playhead." I don't know if there is a way to CHECK if it is on or not. 
; 	resetFromAutoVFX()
; 	;play noise
; 	;now you need to do all that again, since the motion menu is now open. But only do it ONCE more! 
; 	If (dontrestart = 0)
; 		{
; 		dontrestart = 1
; 		goto, restartPoint ;this is stupid but it works. Feel free to improve any of my code.
; 		}
; 	Return reset
; 	}
; else
; 	{
; 	tooltip, %colorr% not expected
; 	;play noise
; 	resetFromAutoVFX()
; 	Return reset
; 	}
; }
; Return ;from autoscaler part 1

; findVFX(foobar) ; searches for text inside of the Motion effect. requires an actual image.
; {
; 	msgbox, made it here4
; ;tooltip, WTF
; ;msgbox, now we are in findVFX
; sleep 5
; MouseGetPos xPos, yPos
; ;CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.

; /*
; if foobar = "scale"
; 	ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\scale_D2017.png
; else if foobar = "anchor_point"
; 	ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
; */

; ;ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2018.png

; ;something was wrong with using %A_WorkingDir% here. now fixed.

; ;ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019.png
; ImageSearch, FoundX, FoundY, xPos-90, yPos, xPos+800, yPos+900, %A_WorkingDir%\%foobar%_D2019_ui100.png
; ;within 0 shades of variation (this is much faster)
; ;obviously, you need to take your own screenshot (look at mine to see what is needed) save as .png, and link to it from the line above.
; ;Again, your UI brightness might be different from mine! I now use the DEFAULT brightness.
; ; if ErrorLevel = 0
; 	; msgbox, error 0
; if ErrorLevel = 1
; 	{
; 	;ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019.png ;within 10 shades of variation (in case SCALE is fully extended with bezier handles, in which case, the other images are real hard to find because the horizontal seperating lines look a BIT different. But if you crop in really closely, you don't have to worry about this. so this part of the code is not really necessary execpt to expand the range to look.
; 	;msgbox, whwhwuhuat
; 	ImageSearch, FoundX, FoundY, xPos-30, yPos, xPos+1200, yPos+1200, *10 %A_WorkingDir%\%foobar%_D2019_ui100.png
; 	}
; if ErrorLevel = 2
; 	{
;     msgbox,,, ERROR LEVEL 2`nCould not conduct the search,1
; 	resetFromAutoVFX()
; 	}
; if ErrorLevel = 1
; 	{
; 	;msgbox, , , error level 1, .7
;     msgbox,,, ERROR LEVEL 1`n%foobar% could not be found on the screeen,1
; 	resetFromAutoVFX()
; 	}
; else
; 	{
; 	;tooltip, The %foobar% icon was found at %FoundX%x%FoundY%.
; 	;msgbox, The %foobar% icon was found at %FoundX%x%FoundY%.
; 	MouseMove, FoundX, FoundY, 0
; 	;msgbox,,,moved to located text,1
; 	sleep 5
; 	findHotText(foobar)
; 	}
; 	msgbox, made it here5
; }




; findHotText(foobar)
; {
; tooltip, ; removes any tooltips that might be in the way of the searcher.
; ; https://www.autohotkey.com/docs/commands/PixelSearch.htm
; ;CoordMode Pixel
; MouseGetPos, xxx, yyy
; msgbox, made it here6
; ;msgbox, foobar is %foobar%
; if (foobar = "scale" ||  foobar = "anchor_point" || foobar = "rotation")
; {
; 	;msgbox,,,scale or the other 3,1
; 	;PixelSearch, Px, Py, xxx+50, yyy, xxx+350, yyy+11, 0x3398EE, 30, Fast RGB ;this is searching to the RIGHT, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI.
; 	PixelSearch, Px, Py, xxx+50, yyy, xxx+350, yyy+11, 0x2d8ceb, 30, Fast RGB ;this is searching to the RIGHT, looking the blueness of the scrubbable hot text. Unfortunately, it sees to start looking from right to left, so if your window is sized too small, it'll possibly latch onto the blue of the playhead/CTI.
; }
; else if (foobar = "anchor_point_vertical")
; {
; 	tooltip, 0.00? ;(looking for that now)
; 	;msgbox,,, looking for 0.00,0.5
; 	;ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019.png ;because i never change the value of the anti-flicker filter, (0.00) and it is always the same distance from the actual hot text that i WANT, it is a reliable landmark. So this is a screenshot of THAT.
; 	ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019_ui100.png ;for a user interface at 100%...
; 	;the *3 allows some minor variation in the searched image.
; 	if ErrorLevel = 1
; 		ImageSearch, Px, Py, xxx+50, yyy, xxx+800, yyy+100, *3 %A_WorkingDir%\anti-flicker-filter_000_D2019_2.png
; }

; ; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anchor_point_D2017.png
; ; ImageSearch, FoundX, FoundY, xPos-70, yPos, xPos+800, yPos+500, %A_WorkingDir%\anti-flicker-filter_000.png

; msgbox, made it here7
; if ErrorLevel
; 	{
;     ;tooltip, blue not Found
; 	sleep 100
; 	resetFromAutoVFX()
; 	;return ;i am not sure if this is needed.
; 	}
; else
; 	{
; 	tooltip, A color within 30 shades of variation was found at X%Px% Y%Py%
; 	;sleep 1000
;     ;MsgBox, A color within 30 shades of variation was found at X%Px% Y%Py%.
; 	if (foobar <> "anchor_point_vertical")
; 	{
		
; 		MouseMove, Px+10, Py+5, 0 ;moves the cursor onto the scrubbable hot text
; 		;msgbox, anything but anchor point vertical
; 		;sleep 1000
; 	}
; 	else if (foobar = "anchor_point_vertical")
; 	{
; 		;msgbox,,,, about to move,0.5
; 		MouseMove, Px+80, Py-20, 0 ;relative to the unrelated 0.00 text (which I've never changed,) this moves the cursor onto the SECOND variable for the anchor point... the VERTICAL number, rather than horizontal.
; 		tooltip, where am I?
; 		;sleep 1000
; 	}
; 	Click down left
	
; 	GetKeyState, stateFirstCheck, %VFXkey%, P
		
; 	if stateFirstCheck = U
; 		{
; 			;a bit of time has passed by now, so if the user is no longer holding the key down at this point, that means that they pressed it an immediately released it.
; 			;I am going to take this an an indicaiton that the user just wants to RESET the value, rather than changing it.
; 			Click up left
; 			Sleep 10
; 			;I am removing the clode below, which acts to reset the whole thing. instead, now this allows me to type in my own custom value.
			
; 			; if (foobar = "scale")
; 			; {
; 				; Send, 100
; 				; sleep 50
; 				; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
; 				; sleep 20
; 			; }
; 			; if (foobar = "rotation")
; 			; {
; 				; Send, 0
; 				; sleep 50
; 				; Send, {enter} ;"enter" can be a volatile and dangerous key, since it has so many other potential functions that might interfere somehow... in fact, I crashed the whole program once by using this and the anchor point script in rapid sucesssion.... but "ctrl enter" doesn't work... maybe numpad enter is a safer bet?
; 				; sleep 20
; 			; }
; 			resetFromAutoVFX()
; 			;return
; 		}
; 	;Now we start the official loop, which will continue as long as the user holds down the VFXkey. They can now simply move the mouse to change the value of the hot text which has been automatically selected for them.
; 	Loop
; 		{
; 		blockinput, off
; 		blockinput, MouseMoveOff
; 		;tooltip, %VFXkey% Instant %foobar% mod
; 		tooltip, ;removes any tooltips that might exist.
; 		sleep 15
; 		GetKeyState, state, %VFXkey%, P
; 		if state = U
; 			{
; 			Click up left
; 			;tooltip, "%VFXkey% is now physically UP so we are exiting now"
; 			sleep 15
; 			resetFromAutoVFX()
; 			; MouseMove, Xbegin, Ybegin, 0
; 			; tooltip,
; 			; ToolTip, , , , 2
; 			; blockinput, off
; 			; blockinput, MouseMoveOff
; 			Return
; 			}
; 		}
; 	}
; }

; ;;;--------------------------------------------------------------------------------------------

; resetFromAutoVFX()
; {
; 	;msgbox,,, is resetting working?,1
; 	global Xbegin
; 	global Ybegin
; 	MouseMove, Xbegin, Ybegin, 0
; 	;MouseMove, global Xbegin, global Ybegin, 0
; 	;MouseMove, Xbeginlol, Ybeginlol, 0
; 	blockinput, off
; 	blockinput, MouseMoveOff
; 	ToolTip, , , , 2
; 	SetTimer, noTip, 333
; }


; ;i should delete or merge this but i think it is used SOMEWHERE....
; clickTransformIcon()
; {
; ControlGetPos, Xcorner, Ycorner, Width, Height, DroverLord - Window Class3, ahk_class Premiere Pro ;you will need to set this value to the window class of your own Effect Controls panel! Use window spy and hover over it to find that info.

; ; Xcorner := Xcorner+83 ;150% ui
; ; Ycorner := Ycorner+98 ;150% ui
; Xcorner := Xcorner+56 ;100% ui
; Ycorner := Ycorner+66 ;100% ui

; MouseMove, Xcorner, Ycorner, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
; sleep 10 ; just to make sure it gets there, this is done twice.
; MouseMove, Xcorner, Ycorner, 0 ;these numbers should move the cursor to the location of the transform icon. Use the message box below to debug this.
; ;msgbox, the cursor should now be positioned directly over the transform icon. `n Xcorner = %Xcorner% `n Ycorner = %Ycorner%
; MouseClick, left
; }


; noTip:
; ToolTip,,,,8
; ;removes the tooltip
; return

; #IfWinActive ahk_exe Adobe Premiere Pro.exe ;---EVERYTHING BELOW THIS LINE WILL ONLY WORK INSIDE PREMIERE PRO! (until canceled with a lone "#IfWinActive")

; ;is the above line really necessary? i dont think so, but i am afraid to touch it.


GetFocusedControl(Option := "ClassNN")
{
	;"Options": ClassNN \ Hwnd \ Text \ List \ All

GuiWindowHwnd := WinExist("A")		;stores the current Active Window Hwnd id number in "GuiWindowHwnd" variable
				;"A" for Active Window

ControlGetFocus, FocusedControl, ahk_id %GuiWindowHwnd%	;stores the  classname "ClassNN" of the current focused control from the window above in "FocusedControl" variable
						;"ahk_id" searches windows by Hwnd Id number

if Option = ClassNN
return, FocusedControl

ControlGet, FocusedControlId, Hwnd,, %FocusedControl%, ahk_id %GuiWindowHwnd%	;stores the Hwnd Id number of the focused control found above in "FocusedControlId" variable

if Option = Hwnd
return, FocusedControlId

if (Option = "Text") or (Option = "All")
ControlGetText, FocusedControlText, , ahk_id %FocusedControlId%		;stores the focused control texts in "FocusedControlText" variable
							;"ahk_id" searches control by Hwnd id number

if Option = Text	
return, FocusedControlText

if (Option = "List") or (Option = "All")
ControlGet, FocusedControlList, List, , , ahk_id %FocusedControlId%	;"List", retrieves  all the text from a ListView, ListBox, or ComboBox controls

if Option = List	
return, FocusedControlList

return, FocusedControl " - " FocusedControlId "`n`n____Text____`n`n" FocusedControlText "`n`n____List____`n`n" FocusedControlList

}



!+.::msgbox, A_workingDir should be %A_WorkingDir%
