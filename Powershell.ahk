#Include %A_ScriptDir%
#Include Utilities.ahk

If( InStr(FileExist("C:\Program Files\PowerShell\7"), "D")) {
    ; Powershell 7
    appPath = "C:\Program Files\PowerShell\7\pwsh.exe"
    cycleWindows(appPath,"-WorkingDirectory ~", "ahk_exe pwsh.exe")
} ElseIf( InStr(FileExist("C:\Program Files\PowerShell\6"), "D")) {
    ; Powershell 6
    appPath = "C:\Program Files\PowerShell\6\pwsh.exe"
    cycleWindows(appPath,"-WorkingDirectory ~", "ahk_exe pwsh.exe")
} Else {
    ; Powershell 5.1
    appPath = %A_AppData%\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell
    cycleWindows(appPath,, "ahk_exe powershell.exe")
}
