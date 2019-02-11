;Capture a rectangular screen region to clipboard - using Snipping Tool non-interactively.
GetKeyState, shiftState, Shift
GetKeyState, controlState, Control
If (controlState != "D") {
    ; Store the previous Capture Mode value
    RegRead, captureMode, HKCU, SOFTWARE\Microsoft\Windows\TabletPC\Snipping Tool\CaptureModeSubKey
    ; Set Capture Mode to `2` (Rectangular Snip)
    RegWrite, REG_DWORD, HKCU, SOFTWARE\Microsoft\Windows\TabletPC\Snipping Tool\CaptureModeSubKey,, 2
    ; Invoke the snipping tool
    RunWait, C:\Windows\system32\SnippingTool.exe /clip
    ; Restore the previous Capture Mode value
    RegWrite, REG_DWORD, HKCU, SOFTWARE\Microsoft\Windows\TabletPC\Snipping Tool\CaptureModeSubKey,, %captureMode%
    ; Save the snip to the hard drive in the snipfolder
    snipFolder = %A_MyDocuments%\Snips
    If (!InStr(FileExist(snipFolder), "D")) {
        FileCreateDir, %snipFolder%
    }
    snipFile = %snipFolder%\Snip-%A_YYYY%-%A_MM%-%A_DD%T%A_Hour%-%A_Min%-%A_Sec%.%A_MSec%.png
    command = (Get-Clipboard -Format Image).Save('%snipFile%')
    RunWait, powershell.exe -WindowStyle Hidden -NoProfile -NonInteractive -NoLogo -Command "%command%"
    if (shiftState = "D") {
        Run, "%snipFile%" 
    }
} Else {
    ; Get the Snipping tool window
    WinGet, snipWin, ID, ahk_exe SnippingTool.exe
    If (snipWin > 1) {
        ; There is one, Activate it.
        WinActivate, ahk_id %snipWin%
    } Else {
        ; There isn't one. Start it.
        Run, C:\Windows\system32\SnippingTool.exe
    }
}