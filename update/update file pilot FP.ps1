# Work in temp directory
Set-Location $env:TEMP

$fileName = 'FPilot.exe'
$downloadUrl = 'https://filepilot.tech/download/latest'

Write-Host "Downloading $fileName..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $fileName
Write-Host "Downloaded to: $fileName"

# Copy the dll to destination
Copy-Item $filename "D:\all\all\File Pilot\FPilot.exe" -Force
