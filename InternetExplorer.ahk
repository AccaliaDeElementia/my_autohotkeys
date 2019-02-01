#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_class IEFrame
appPath = "C:\Program Files\internet explorer\iexplore.exe"
cycleWindows(hwnd1, hwnd2, appPath)
