winget install Microsoft.PowerShell
winget install Bitwarden.Bitwarden
winget install Git.Git
winget install Microsoft.DotNet.SDK.7 --log C:\temp\install.log
winget install Google.Drive
winget install JetBrains.Toolbox
winget install ZeroTier.ZeroTierOne
winget install Docker.DockerDesktop
winget install 7zip.7zip # TODO: backup and restore the registry properties under HKEY_CURRENT_USER\Software\7-Zip


# Make git save credentials
git config --global --unset credential.helper
git config --global credential.helper manager
git config --global core.autocrlf false # THIS IS WHAT YOU WANT!!!



<#
Help:
https://superuser.com/questions/605633/how-do-i-escape-spaces-for-the-ftype-command-in-windows
https://stackoverflow.com/questions/48280464/how-can-i-associate-a-file-type-with-a-powershell-script

https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/ftype
https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/assoc
#>
# Associate .ahk with AutoHotkey Files
cmd /c 'assoc .ahk="AutoHotkey.File"'
cmd /c 'ftype "AutoHotkey.File"="D:\all\all\AutoHotkey\AutoHotkey64.exe" %1'



# Create shortcuts
function mkShortcut($folder, $fileName, $targetPath, $arguments)
{
    $s = (New-Object -COM WScript.Shell).CreateShortcut("$folder\$fileName.lnk")
    $s.TargetPath = $targetPath
    $s.Arguments = '"' + ($arguments -join '" "') + '"'
    $s.WorkingDirectory = Split-Path $targetPath
    $s.Save()
}

$StartUPFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
$StartFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"

mkShortcut $StartUPFolder "AutoHotkeyU64.ahk" "D:\all\all\AutoHotkey\AutoHotkey64.ahk"
mkShortcut $StartUPFolder "Launcher.exe" "D:\all\all\AutoHotKey-Launcher\Launcher.exe" "D:\all\all\AutoHotKey-Launcher\Launcher.ahk"
mkShortcut $StartUPFolder "Flow.Launcher.exe" "D:\all\all\Flow.Launcher\Flow.Launcher.exe"
mkShortcut $StartUPFolder "ShareX.exe" "D:\all\all\ShareX-portable\ShareX.exe"
$PageAntKeys = (Get-ChildItem "$env:USERPROFILE\.ssh\" -Filter *.ppk).FullName
mkShortcut $StartUPFolder "PageAnt.exe" "D:\all\all\PortableApps\PortableApps\PuTTYPortable\App\putty\PAGEANT.EXE" $PageAntKeys

mkShortcut $StartFolder "JDownloader2.exe" "D:\all\all\JDownloader v2.0\JDownloader2.exe"



# Ignore some folders in windows defender
Add-MpPreference -ExclusionPath "D:\all\work-nagarro\"
Add-MpPreference -ExclusionPath "D:\all\work\"
Add-MpPreference -ExclusionPath "$env:USERPROFILE\AppData\Local\JetBrains"









# update path - i think i need to restart after this
<#
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;D:\all\all\PortableGit\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

# set java path
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\live")
#>





enable long paths:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem\LongPathsEnabled set to 1.




# Disable Lock Screen after screen is simply turned off (ie after idle timeout)
# See: https://www.tenforums.com/tutorials/158033-change-time-require-sign-after-display-turns-off-windows-10-a.html

Remove-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name DelayLockInterval -Verbose


# PowerShell

# Allow .ps1 scripts created by me to run, disallow internet scripts to run.
# See https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3#use-group-policy-to-manage-execution-policy
Set-ExecutionPolicy RemoteSigned


# Associate .ps1 with Powershell 7 Files
# Run this in pwsh admin terminal
cmd /c 'assoc .ps1="Powershell 7 File"'
cmd /c 'Ftype "Powershell 7 File"=pwsh.exe -NoExit -File "%1"'


# Uninstall OneDrive
winget uninstall Microsoft.OneDrive

Remove-Item -Force -Recurse "$env:USERPROFILE\OneDrive"
Remove-Item -Force -Recurse  "C:\OneDriveTemp"
Remove-Item -Force -Recurse  "$env:LOCALAPPDATA\Microsoft\OneDrive"
Remove-Item -Force -Recurse  "$env:ProgramData\Microsoft OneDrive"



# Uninstall Feces
Get-AppxPackage MicrosoftTeams* | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -online | where-object {$_.PackageName -like "*MicrosoftTeams*"} | Remove-AppxProvisionedPackage -online –Verbose



# Unpin folders from explorer quick access

# Source: https://stackoverflow.com/a/46357909/2161279
function unpinFromExplorer($folderPath)
{
    $qa = New-Object -ComObject shell.application
    ($qa.Namespace("shell:::{679F85CB-0220-4080-B29B-5540CC05AAB6}").Items() | Where-Object { $_.Path -EQ $folderPath }).InvokeVerb("unpinfromhome")
}


unpinFromExplorer "C:\Users\${env:USERNAME}\Documents"
unpinFromExplorer "C:\Users\${env:USERNAME}\Pictures"
unpinFromExplorer "C:\Users\${env:USERNAME}\Music"
unpinFromExplorer "C:\Users\${env:USERNAME}\Videos"



stop-process -name explorer –force



# Open windows explorer to "My PC" instead of "recents"
# https://superuser.com/questions/819521/how-do-i-make-windows-10s-file-explorer-open-this-pc-by-default
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 1 -Name 'LaunchTo'

# Show Files extensions
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'HideFileExt'

# Show hidden files
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 1 -Name 'Hidden'

# Always show thumbnails 
# https://www.tenforums.com/tutorials/18834-enable-disable-thumbnail-previews-file-explorer-windows-10-a.html
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'IconsOnly'





# Disable Windows Snap Assist (show what can be snapped next to this window)
# Ref: https://www.tenforums.com/tutorials/4343-turn-off-snap-windows-windows-10-a.html#option3
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'SnapAssist'

# Disable AutoPlay of USB devices
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Value 1 -Name 'DisableAutoplay'

# Disable app suggestions from Start menu
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-338388Enabled'

# Disallow windows to update over metered networks
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 0 -Name 'AllowAutoWindowsUpdateDownloadOverMeteredNetwork'




# Fuck search, Fuck Bing and Fuck Cortana
# https://www.howtogeek.com/224159/how-to-disable-bing-in-the-windows-10-start-menu/
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name BingSearchEnabled -Value 0;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name CortanaConsent -Value 0;







# Create the network shares
# ❗ NOT As admin ❗ 

# first go in explorer here and save passwords
\\tbp-nuc
\\roxanas-mbp

New-PSDrive -Persist -Scope Global -Verbose -Name "P" -Root "\\tbp-nuc\patrunjel\Patrunjel\Patrunjel" -PSProvider "FileSystem" 
New-PSDrive -Persist -Scope Global -Verbose -Name "T" -Root "\\tbp-nuc\torrentz" -PSProvider "FileSystem" 
New-PSDrive -Persist -Scope Global -Verbose -Name "W" -Root "\\tbp-nuc\tbp" -PSProvider "FileSystem" 
New-PSDrive -Persist -Scope Global -Verbose -Name "X" -Root "\\tbp-nuc\torrentza" -PSProvider "FileSystem" 
New-PSDrive -Persist -Scope Global -Verbose -Name "Z" -Root "\\roxanas-mbp\pokambrian" -PSProvider "FileSystem" 



# Precision touchpad settings
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name ThreeFingerTapEnabled   -Value 4;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name CustomThreeFingerTap    -Value 4;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name ThreeFingerUp           -Value 16;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name ThreeFingerSlideEnabled -Value 65535;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name ThreeFingerRight        -Value 9;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name ThreeFingerLeft         -Value 8;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name ThreeFingerDown         -Value 17;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name FourFingerTapEnabled    -Value 0;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name CustomFourFingerTap     -Value 0;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name FourFingerLeft          -Value 1;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name FourFingerSlideEnabled  -Value 1;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name FourFingerRight         -Value 1;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name FourFingerDown          -Value 3;
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad" -Name FourFingerUp            -Value 2;



# Manual stuff



restore windows terminal settings

make autostart
- telegram
- alt snap
- everything + everything service


add taskbar shortcut to
- mediamonkey




# Time and date format
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name iFirstDayOfWeek -Value "0";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sLongDate -Value "dddd, d MMMM, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortDate -Value "dddd, d MMMM, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortTime -Value "HH:mm";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sTimeFormat -Value "HH:mm:ss";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name syEARmONTH -Value "MMMM yyyy";


# Disable auto brightness
# https://www.elevenforum.com/t/turn-on-or-off-content-adaptive-brightness-control-in-windows-11.2608/
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name DisableCABC -Value "1";


# Power config 
# https://jakubjares.com/2018/11/08/powercfg/
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/update-power-settings

# Enable battery saver as soon as i unplug
powercfg /setdcvalueindex SCHEME_ALL SUB_ENERGYSAVER ESBATTTHRESHOLD 100
powercfg /setacvalueindex SCHEME_ALL SUB_ENERGYSAVER ESBATTTHRESHOLD 100


# Turn off automatic display dimming on battery saver
powercfg /setdcvalueindex SCHEME_ALL SUB_ENERGYSAVER ESBRIGHTNESS 100
powercfg /setacvalueindex SCHEME_ALL SUB_ENERGYSAVER ESBRIGHTNESS 100

# Disable Modern Standby
# It's a piece of shit. Fuck this fucking shit. Whenever my screen turns off, laptop goes to sleep. This if fucking retarded
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Power" -Name PlatformAoAcOverride -Value 0
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Power" -Name CsEnabled -Value 0
