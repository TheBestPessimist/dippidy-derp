# Work in temp directory
Set-Location $env:TEMP

# Get the latest release info
$repo = "AutoHotkey/AutoHotkey"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"
$release = Invoke-RestMethod -Uri $apiUrl

# Find the asset
$asset = $release.assets | Where-Object { $_.name -like "*.zip" }

# Download the file
$downloadUrl = $asset.browser_download_url
$fileName = $asset.name


Write-Host "Downloading $fileName..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $fileName
Write-Host "Downloaded to: $fileName"

# Remove old ahk folder if it exists
Remove-Item "ahk" -Recurse -Force

# Unzip
& "C:\Program Files\7-Zip\7z.exe" x $fileName -o"ahk" -y

# Remove things i don't need
Remove-Item ahk/AutoHotkey32.exe
Remove-Item ahk/license.txt

# Kill ahk if running
Get-Process -Name "AutoHotkey64" -ErrorAction SilentlyContinue | Stop-Process -Force

# Copy files
robocopy /E /Z /R:5 /W:5 /TBD /unicode /V /XJ /ETA /COPY:DT /DCOPY:DT /MT:32 'ahk' 'D:/all/all/AutoHotkey/'

# Restart ahk
Start-Process "D:/all/all/AutoHotkey/AutoHotkey64.exe"
