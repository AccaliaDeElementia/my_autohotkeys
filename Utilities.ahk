; Use Sanity
; Utilities for being awesome

flashActiveWindow(count=3) {   
    Static FW="0123456789ABCDEF01234" ; FLASHWINFO Structure
    WinGet, hWnd, ID, A
    NumPut(20,FW) ; UINT cbSize;
    NumPut(hWnd,FW,4) ; HWND hwnd;
    NumPut(1,FW,8) ; DWORD dwFlags; FlashCaption
    NumPut(5,FW,12) ; UINT uCount;
    NumPut(0,FW,16) ; DWORD dwTimeout;
    Return DllCall( "FlashWindowEx", UInt, &FW )
}

cycleWindows(appPath, appArgs = "", winTitle = "", winText = "", excludeTitle = "", excludeText = "") {
    ; Get matching windows
    WinGet, hWnd, LIST, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    ; Extract the last Window Id (we don't what index it'll be at first)
    hWndLast := hWnd%hWnd%
    ; hold Control to force launching app
    GetKeyState, controlState, Control
    ; Hold shift to cycle through the windows bottom to top
    GetKeyState, shiftState, Shift
    if (hWnd1 > 0 && controlState != "D") {
        ; Fetch the active window
        WinGet, activeWin, ID, A
        if (hWnd1 = activeWin AND hWnd2 > 1) {
            ; App is active, cycle through windows
            if (shiftState = "D" AND hWndLast > 1) {
                ; Cycle backwards, bring bottom to top
                WinActivate, ahk_id %hWndLast%
            } else {
                ; Cycle Forwards, Send top to bottom and bring next to top
                WinSet, Bottom,, A
                WinActivate, ahk_id %hWnd2%
            }
        } else {
            ; App not active, bring it to the front
            WinActivate, ahk_id %hWnd1%
        }
        ; This doesn;t seem to work, but try to flash the window to make it easier to find on multimonitor setups
        flashActiveWindow()
    } else {
        ; Not running or chose to launch new.
        ; Launch the sucker!
        Run, %appPath% %appArgs%
    }
}

MakeScreenSnip() {
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
        RunWait, powershell.exe -WindowStyle Hidden -NoProfile -NonInteractive -NoLogo -Command "%command%", , Hide
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
}