#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, activeHWnd, ID, A
WinGet, hWnd, LIST, ahk_exe mstsc.exe
appPath = "C:\Windows\system32\mstsc.exe"
GetKeyState, controlState, Control
if (hWnd1 = activeHWnd && controlState != "D") {
    WinSet, Bottom,, A
} else {
    cycleWindows(hwnd1, hwnd2, appPath)
}
