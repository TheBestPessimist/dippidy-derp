# Work in temp directory
Set-Location $env:TEMP

$fileName = 'taskslinger.exe'
$downloadUrl = 'https://taskslinger.net/download/latest/website/x64'

Write-Host "Downloading $fileName..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $fileName
Write-Host "Downloaded to: $fileName"

# Copy the dll to destination
Copy-Item $filename "D:\all\all\TaskSlinger\taskslinger.exe" -Force
