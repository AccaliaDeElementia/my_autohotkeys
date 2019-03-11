#Include %A_ScriptDir%
#Include Utilities.ahk

Apppath=%A_AppData%\..\Local\slack\slack.exe
cycleWindows(Apppath,, "ahk_exe slack.exe")
