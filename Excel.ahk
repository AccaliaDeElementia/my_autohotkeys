#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_exe EXCEL.EXE
appPath = "C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE"
cycleWindows(hwnd1, hwnd2, appPath)
