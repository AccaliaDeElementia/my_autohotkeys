#Include %A_ScriptDir%
#Include Utilities.ahk

I_Icon = %A_ScriptDir%\icons\Pomeranian\tumblr_inline_oz2kqobSxv1tcps8u_540.ico
IfExist, %I_ICON%
	Menu, Tray, Icon, %I_ICON%

*PrintScreen:: MakeScreenSnip()