#Include %A_ScriptDir%
#Include Utilities.ahk

appPath = %A_AppData%\Microsoft\Windows\Start Menu\Programs\Windows PowerShell\Windows PowerShell
cycleWindows(appPath,, "ahk_exe powershell.exe")
