#Include %A_ScriptDir%
#Include Utilities.ahk

SetTitleMatchMode, RegEx
WinGet, hWnd, LIST, Microsoft Edge$
WinGet, hWndLast, IDLast, Microsoft Edge$
appPath = "microsoft-edge:https://google.com"
cycleWindows(hwnd1, hwnd2, hWndLast, appPath)