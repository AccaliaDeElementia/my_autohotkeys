
WinGet, thing, ID, ahk_exe mumble.exe
if WinExist (ahk_exe mumble.exe) {
Send, {F24}
} else {
Run, C:\Program Files (x86)\Mumble\mumble.exe
}