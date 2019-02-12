#Include %A_ScriptDir%
#Include Utilities.ahk

SetTitleMatchMode, RegEx

WinGet, hWnd, LIST, Google Chrome$ ahk_exe chrome.exe
WinGet, hWndLast, IDLast, Google Chrome$ ahk_exe chrome.exe
appPath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
cycleWindows(hwnd1, hwnd2, hWndLast, appPath)