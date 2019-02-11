;Capture a rectangular screen region to clipboard - using Snipping Tool non-interactively.
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
    command = (Get-Clipboard -Format Image).Save('%A_MyDocuments%\Snip-%A_YYYY%-%A_MM%-%A_DD%T%A_Hour%-%A_Min%-%A_Sec%.%A_MSec%.png')
    Run, powershell.exe -WindowStyle Hidden -NoProfile -NonInteractive -NoLogo -Command "%command%"
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