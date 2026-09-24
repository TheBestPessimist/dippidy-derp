# Work in temp directory
Set-Location $env:TEMP

$fileName = 'calibre-portable-installer.exe'
$downloadUrl = 'https://calibre-ebook.com/dist/portable'

Write-Host "Downloading $fileName..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $fileName
Write-Host "Downloaded to: $fileName"

$target = 'D:\all\Calibre Portable'
& ('./' + $fileName) $target
