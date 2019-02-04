#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_exe WINWORD.EXE
appPath = "C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE"
cycleWindows(hwnd1, hwnd2, appPath)
