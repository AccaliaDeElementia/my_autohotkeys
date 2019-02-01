#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_exe code.exe
appPath = "%A_AppData%\..\Local\Programs\Microsoft VS Code\code.exe"
cycleWindows(hwnd1, hwnd2, appPath)
