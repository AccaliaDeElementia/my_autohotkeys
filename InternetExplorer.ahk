#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, hWnd, LIST, ahk_class IEFrame
WinGet, hWndLast, IDLast, ahk_class IEFrame
cycleWindows(hwnd1, hwnd2, hWndLast, "C:\Program Files\internet explorer\iexplore.exe", "https://google.com")
