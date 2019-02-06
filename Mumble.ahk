
WinGet, thing, ID, ahk_exe mumble.exe
if (thing > 0) {
    Run, C:\Program Files (x86)\Mumble\mumble.exe rpc togglemute
} else {
    Run, C:\Program Files (x86)\Mumble\mumble.exe
}