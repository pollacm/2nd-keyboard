;C:\Users\Owner\Documents\Adobe\Premiere Pro\13.0\Profile-Owner\Win

workPC = "Yes"

if workPC = "No"
{
    ;SetWorkingDir, C:\Users\Owner\source\repos\2nd-keyboard\support_files
}
if workPC = "Yes"
{
    SetWorkingDir, C:\Users\cxp6696\source\repos\2nd-keyboard\support_files
}
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
	Send ^!+3 ;if focus had already been on the timeline, this would have switched to the next sequence in some arbitrary order.
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
	Send ^!+5

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
BlockInput, SendAndMouse
BlockInput, MouseMove
BlockInput, On

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

MouseMove, X2X-15, YY+10, 0 ;--------------------for 100% UI scaling, this moves the cursor onto the magnifying glass
;MouseMove, XX-25, YY+10, 0 ;--------------------for 150% UI scaling, this moves the cursor onto the magnifying glass
;msgbox, should be in the center of the magnifying glass now.
sleep 5 ;was sleep 50
;This types in the text you wanted to search for. Like "pop in." We can do this because the entire find box text was already selected by Premiere. Otherwise, we could click the magnifying glass if we wanted to , in order to select that find box.
Send %item%

sleep 5

if(workPC = "No")
{
	MouseMove, -80, 72, 0, R ;----------------------(for 100% UI) 	
}
if(workPC = "Yes")
{
	MouseMove, -120, 110, 0, R ;----------------------(for 150% UI) relative to the position of the magnifying glass (established earlier,) this moves the cursor down and directly onto the preset's icon. In my case, it is inside the "presets" folder, then inside of another folder, and the written name should be completely unique so that it is the first and only item.	
}

;msgbox, The cursor should be directly on top of the preset's icon. `n If not, the script needs modification.
sleep 5
MouseGetPos, iconX, iconY, Window, classNN ;---now we have to figure out the ahk_class of the current panel we are on. It used to be DroverLord - Window Class14, but the number changes anytime you move panels around... so i must always obtain the information anew.
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
blockinput, MouseMoveOff ;returning mouse movement ability
BlockInput, off ;do not comment out or delete this line -- or you won't regain control of the keyboard!! However, CTRL+ALT+DEL will still work if you get stuck!! Cool.

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
insertSFX(leSound, layerToInsertOn:=1)
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
sleep 10
Send {,}

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


!+.::msgbox, A_workingDir should be %A_WorkingDir%