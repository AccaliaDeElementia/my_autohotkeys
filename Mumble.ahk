
WinGet, thing, ID, ahk_exe mumble.exe
if (thing > 0) {
Send, {F24}
} else {
Run, C:\Program Files (x86)\Mumble\mumble.exe
}