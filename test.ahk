;MsgBox, %A_MyDocuments%

value = (Get-Clipboard -Format Image).Save('%A_MyDocuments%\Snip-%A_YYYY%-%A_MM%-%A_DD%T%A_Hour%-%A_Min%-%A_Sec%.%A_MSec%.png')
MsgBox, %value%
