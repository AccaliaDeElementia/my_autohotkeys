#Include %A_ScriptDir%
#Include Utilities.ahk

WinGet, activeHWnd, ID, A
WinGet, hWnd, ID, ahk_exe mstsc.exe
GetKeyState, controlState, Control
if (hWnd = activeHWnd && controlState != "D") {
    WinSet, Bottom,, A
} else {
    cycleWindows( "C:\Windows\system32\mstsc.exe",, "ahk_exe mstsc.exe")
}
