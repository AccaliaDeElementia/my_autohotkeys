#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_exe OUTLOOK.EXE
appPath = "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
cycleWindows(hwnd1, hwnd2, appPath)
