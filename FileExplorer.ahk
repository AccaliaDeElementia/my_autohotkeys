#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_class CabinetWClass
WinGet, hWndLast, IDLast, ahk_class CabinetWClass
appPath = "C:\windows\explorer.exe"
cycleWindows(hwnd1, hwnd2, hWndLast, appPath)
