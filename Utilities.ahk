; Use Sanity
; Utilities for being awesome

; FlashWindow Flag Enumeration
; There's probably a better way to do this.
FlashWindowFlag := {}
FlashWindowFlag.STOP := 0
FlashWindowFlag.CAPTION := 1
FlashWindowFlag.TRAY := 2
FlashWindowFlag.ALL := 3
FlashWindowFlag.START := 4
FlashWindowFlag.UNTILFORGROUND := 12

; Flash a non active window
FlashWindow(hWnd := 0, dwFlags := 3, uCount := 5, dwTimeout := 0) {
   Static A64 := (A_PtrSize = 8 ? 4 : 0) ; alignment for pointers in 64-bit environment
   Static cbSize := 4 + A64 + A_PtrSize + 4 + 4 + 4 + A64
   VarSetCapacity(FLASHWINFO, cbSize, 0) ; FLASHWINFO structure
   Addr := &FLASHWINFO
   Addr := NumPut(cbSize,    Addr + 0, 0,   "UInt")
   Addr := NumPut(hWnd,      Addr + 0, A64, "Ptr")
   Addr := NumPut(dwFlags,   Addr + 0, 0,   "UInt")
   Addr := NumPut(uCount,    Addr + 0, 0,   "UInt")
   Addr := NumPut(dwTimeout, Addr + 0, 0,   "Uint")
   Return DllCall("User32.dll\FlashWindowEx", "Ptr", &FLASHWINFO, "UInt")
}

; Cycle through the windows in an application
cycleWindows(appPath, appArgs = "", winTitle = "", winText = "", excludeTitle = "", excludeText = "") {
    ; Hold Control to force launching app
    GetKeyState, controlState, Control
    ; Hold shift to cycle through the windows bottom to top
    GetKeyState, shiftState, Shift
    ; Get matching windows
    WinGet, hWnd, LIST, %winTitle%, %winText%, %excludeTitle%, %excludeText%
    ; Extract the last Window Id (we don't what index it'll be at first)
    hWndLast := hWnd%hWnd%
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
    } else {
        ; Not running or chose to launch new.
        ; Launch the sucker!
        If (StrLen(appArgs) > 0) {
            ; Launch with Arguments
            Run, %appPath% %appArgs%
        } Else {
            ; Launch without arguments (otherwise shortcuts couldn't be launched reliably)
            Run, %appPath%
        }
    }
}

MakeScreenSnip() {
    ; If shift was held when activating the hotkey open the saved snip in the default png image handler
    GetKeyState, shiftState, Shift
    ; If control was held when activating the hotkey just open the snippingtool
    GetKeyState, controlState, Control
    If (controlState != "D") {
        ; Store the previous Capture Mode value
        RegRead, captureMode, HKCU, SOFTWARE\Microsoft\Windows\TabletPC\Snipping Tool\CaptureModeSubKey
        ; Set Capture Mode to `2` (Rectangular Snip)
        RegWrite, REG_DWORD, HKCU, SOFTWARE\Microsoft\Windows\TabletPC\Snipping Tool\CaptureModeSubKey,, 2
        ; Invoke the snipping tool - This will take a rectangular snip andx store it on the clipboard
        RunWait, C:\Windows\system32\SnippingTool.exe /clip
        ; Restore the previous Capture Mode value
        RegWrite, REG_DWORD, HKCU, SOFTWARE\Microsoft\Windows\TabletPC\Snipping Tool\CaptureModeSubKey,, %captureMode%

        ; Save the snip to the hard drive in the snipfolder
        ; First make sure the destination exists
        snipFolder = %A_MyDocuments%\Snips
        If (!InStr(FileExist(snipFolder), "D")) { ; TODO: what if it's a file?
            FileCreateDir, %snipFolder%
        }
        ; Construct the file name to save. Could have done this shorter in powershell, but we need it for later.
        snipFile = %snipFolder%\Snip-%A_YYYY%-%A_MM%-%A_DD%T%A_Hour%-%A_Min%-%A_Sec%.%A_MSec%.png
        ; Insert the filename into a powershell oneliner to save the clipboard as a file
        command = (Get-Clipboard -Format Image).Save('%snipFile%')
        ; Run the powershell snippit, making sure the window stays hidden and out of the way
        RunWait, powershell.exe -WindowStyle Hidden -NoProfile -NonInteractive -NoLogo -Command "%command%", , Hide
        ; If we were holding shift at the start of this hotkey open the resulting file using the default file handler
        if (shiftState = "D") {
            Run, "%snipFile%" 
        }
    } Else {
        ; We were holding control, we should launch the snipping tool directly
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