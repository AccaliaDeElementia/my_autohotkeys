; Use Sanity
; Utilities for being awesome
getMonitorForPoint(x, y, default = 1) {
    SysGet, monitorCount, MonitorCount
    Loop, %monitorCount% 
    {
        ; Check if the window is on this monitor. 
        SysGet, monitor, Monitor, %A_Index% 
        if (x >= monitorLeft && x <= monitorRight && y >= monitorTop && y <= monitorBottom) {
            return A_Index
        }
    }
    return default
}

getMonitorForWindow(windowId, default = 1) {
    WinGetPos, x, y, , , ahk_id %windowId%
    ; Adjust the point to be inside the window chrome (prevents maximized windows from misdetecting monitor)
    x := x + 24
    y := y + 24
    return GetMonitorForPoint(x, y, default)
}

getMonitorForMouse(default = 1) {
    CoordMode, Mouse, Screen
    MouseGetPos, mouseX, mouseY
    return GetMonitorForPoint(mouseX, mouseY, default)
}

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

cycleWindows(hWnd, nextHWnd, lastHWnd, launchPath) {
    GetKeyState, controlState, Control
    GetKeyState, shiftState, Shift
    if (hWnd > 0 && controlState != "D") {
        WinGet, activeWin, ID, A
        if (hWnd = activeWin AND nextHWnd > 1) {
            if (shiftState = "D" AND lastHWnd > 1) {
                ; Cycle backwards, bring bottom to top
                WinActivate, ahk_id %lastHWnd%
            } else {
                ; Cycle Forwards, Send top to bottom and bring next to top
                WinSet, Bottom,, A
                WinActivate, ahk_id %nextHWnd%
            }
        } else {
            ; target hWnd not active, bring it to the front
            WinActivate, ahk_id %hWnd%
        }
        ; This doesn;t seem to work, but try to flash the window to make it easier to find on multimonitor setups
        flashActiveWindow()
    } else {
        ; Not running or chose to launch new.
        ; Launch the sucker!
        Run, %launchPath%
    }
}
