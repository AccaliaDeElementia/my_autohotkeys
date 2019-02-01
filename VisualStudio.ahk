#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_exe devenv.exe
appPath = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
cycleWindows(hwnd1, hwnd2, appPath)