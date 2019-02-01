#Include %A_ScriptDir%
#Include Utilities.ahk

SetTitleMatchMode, RegEx

WinGet, hWnd, LIST, ahk_exe chrome.exe, , ^DevTools
appPath = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
cycleWindows(hwnd1, hwnd2, appPath)