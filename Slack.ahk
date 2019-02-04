#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_exe slack.exe
WinGet, hWndLast, IDLast, ahk_exe slack.exe
appPath = "%A_AppData%\..\Local\slack\slack.exe"
cycleWindows(hwnd1, hwnd2, hWndLast, appPath)
