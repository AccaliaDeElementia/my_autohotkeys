#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_exe powershell.exe
WinGet, hWndLast, IDLast, ahk_exe powershell.exe
appPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
cycleWindows(hwnd1, hwnd2, hWndLast, appPath)
