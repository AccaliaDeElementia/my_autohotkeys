#Include %A_ScriptDir%
#Include Utilities.ahk

SetTitleMatchMode, RegEx
#Include %A_ScriptDir%
#Include Utilities.ahk

WinGetClass, title, A
MsgBox, % "'" . title . "' Explorer Windows"
;appPath = "C:\Program Files\internet explorer\iexplore.exe"
;cycleWindows(hwnd1, hwnd2, appPath)
