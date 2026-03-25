# Work in temp directory
Set-Location $env:TEMP

# Get the latest release info
$repo = "AutoHotkey/AutoHotkey"
$apiUrl = "https://api.github.com/repos/$repo/releases/latest"
$release = Invoke-RestMethod -Uri $apiUrl

# Find the asset matching "mpv-dev-x86_64-v3"
$asset = $release.assets | Where-Object { $_.name -like "*.zip" }


# Download the file
$downloadUrl = $asset.browser_download_url
$fileName = $asset.name


Write-Host "Downloading $fileName..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $fileName
Write-Host "Downloaded to: $fileName"

& "C:\Program Files\7-Zip\7z.exe" x $fileName -o"ahk" -y

explorer ahk
