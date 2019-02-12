forEach ($file in Get-ChildItem . -Filter *.png) { 
    & 'C:\Program Files\ImageMagick-7.0.8-Q16\magick.exe' `
        convert .\$file `
        -resize 64x64 `
        -gravity center `
        -extent 64x64 +repage `
        -define icon:auto-resize=64,48,62,16 `
        .\$($file.Basename).ico
}