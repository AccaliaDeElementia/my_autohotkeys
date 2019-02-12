forEach ($file in Get-ChildItem . -Filter *.png) {
    & 'C:\Program Files\ImageMagick-7.0.8-Q16\magick.exe' `
        convert .\$file `
        -define icon:auto-resize=64,48,62,16 `
        ..\$($file.Basename).ico
}