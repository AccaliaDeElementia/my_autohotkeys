#Include %A_ScriptDir%
#Include Utilities.ahk

appPath = %A_AppData%\..\Local\Programs\Microsoft VS Code\code.exe
cycleWindows(appPath,,"ahk_exe code.exe")
