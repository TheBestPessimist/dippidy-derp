#-----------------
winget install Microsoft.PowerShell
winget install Bitwarden.Bitwarden
winget install Git.Git
winget install Microsoft.DotNet.SDK.7 --log C:\temp\install.log
winget install Google.GoogleDrive
winget install JetBrains.Toolbox
winget install ZeroTier.ZeroTierOne
winget install Docker.DockerDesktop
winget install 7zip.7zip # TODO: backup and restore the registry properties under HKEY_CURRENT_USER\Software\7-Zip
winget install mediainfo-cli
winget install File-New-Project.EarTrumpet
# Uninstall widgets
winget uninstall "Windows web experience Pack"


#-----------------
# Make git save credentials
git config --global --unset credential.helper
git config --global credential.helper manager
git config --global core.autocrlf false # THIS IS WHAT YOU WANT!!!

#-----------------
# NEED ADMIN
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

#-----------------
# NEED ADMIN
# Ignore some folders in windows defender
Add-MpPreference -ExclusionPath "D:\all\work-nagarro\"
Add-MpPreference -ExclusionPath "D:\all\work-bgts\"
Add-MpPreference -ExclusionPath "D:\all\work\"
Add-MpPreference -ExclusionPath "$env:USERPROFILE\AppData\Local\JetBrains"

#-----------------
# NEED ADMIN
# Allow .ps1 scripts created by me to run, disallow internet scripts to run.
# See https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3#use-group-policy-to-manage-execution-policy
Set-ExecutionPolicy RemoteSigned

#-----------------
# NEED ADMIN
# Associate .ps1 with Powershell
# Run this in pwsh admin terminal
cmd /c 'assoc .ps1="Powershell.File"'
cmd /c 'Ftype "Powershell.File"=pwsh -NoExit -File "%1"'

#-----------------
# NEED ADMIN
# Uninstall OneDrive
winget uninstall Microsoft.OneDrive
Remove-Item -Force -Recurse "$env:USERPROFILE\OneDrive"
Remove-Item -Force -Recurse  "C:\OneDriveTemp"
Remove-Item -Force -Recurse  "$env:LOCALAPPDATA\Microsoft\OneDrive"
Remove-Item -Force -Recurse  "$env:ProgramData\Microsoft OneDrive"

#-----------------
# NEED ADMIN
# Uninstall Feces
Get-AppxPackage MicrosoftTeams* | Remove-AppxPackage -AllUsers
Get-AppxProvisionedPackage -online | where-object {$_.PackageName -like "*MicrosoftTeams*"} | Remove-AppxProvisionedPackage -online –Verbose

#-----------------
# NEED ADMIN
# Disable th garbage called 'UserChoice Protection Driver (UCPD)
# https://www.reddit.com/r/PowerShell/comments/1g8jdg6/works_in_ise_but_not_in_terminal_windows_11/
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\UCPD" -Name “Start” -Value 4 -PropertyType DWORD -Force

Disable-ScheduledTask -TaskName "\Microsoft\Windows\AppxDeploymentClient\UCPD velocity"

#-----------------
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

# Hide Cortana crap taskbar button and search bar
# Hide Task View taskbar button
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Value 0 -Name 'SearchboxTaskbarMode'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'ShowCortanaButton'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'ShowTaskViewButton'

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

# Disable "Use the Print Screen key to open Snipping Tool"
# https://www.bleepingcomputer.com/news/microsoft/windows-11-changing-print-screen-to-open-snipping-tool-by-default/
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard" -Name PrintScreenKeyForSnippingEnabled -Value 0;

# Enable the old right click menu
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

# Time and date format
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name iFirstDayOfWeek -Value "0";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sLongDate -Value "dddd, d MMMM, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortDate -Value "dddd, d MMMM, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortTime -Value "HH:mm";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sTimeFormat -Value "HH:mm:ss";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name syEARmONTH -Value "MMMM yyyy";

# Never combine application's buttons
# https://superuser.com/questions/135015/set-never-combine-in-windows-7-using-the-registry
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\' -Value 2 -Name 'TaskbarGlomLevel'

# Set working hours to as much as possible so that windows won't try to update or restart
# Start @ 7:00 AM
# End   @ 1:00 AM (18 hours)
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 7 -Name 'ActiveHoursStart'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 1 -Name 'ActiveHoursEnd'

# Disable some start menu bullshit
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name SystemPaneSuggestionsEnabled
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name PreInstalledAppsEnabled
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name OemPreInstalledAppsEnabled

# Automatically pick an accent color from my background
# Set the accent color on all surfaces
# Ref: https://serverfault.com/questions/867018/gpo-windows-10-set-accent-color-to-auto-from-background
# Ref: https://www.tenforums.com/tutorials/5768-turn-off-start-taskbar-action-center-color-windows-10-a.html
# Ref: https://www.tenforums.com/tutorials/32174-turn-off-show-color-title-bars-borders-windows-10-a.html
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop'-Value 1 -Name 'AutoColorization'
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\DWM'-Value 1 -Name 'ColorPrevalence'
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'-Value 1 -Name 'ColorPrevalence'

# Disable the retarded notification "Could Not Reconnect All Network Drives", which is a fucking lie, Microsoft
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider' -Value 0 -Name 'RestoreConnection'

# Disable sound ducking in sound settings -> communications
# https://www.sevenforums.com/tutorials/13210-system-sounds-auto-leveling-disable.html
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name UserDuckingPreference -Value 3;

# Disable Windows Welcome Experience
# https://www.tenforums.com/tutorials/76252-turn-off-windows-welcome-experience-windows-10-a.html
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-310093Enabled'

# Disable Windows Get tips, tricks, and suggestions as you use Windows
# https://www.tenforums.com/tutorials/30869-turn-off-tip-trick-suggestion-notifications-windows-10-a.html
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-338389Enabled'

# Disable Lock Screen after screen is simply turned off (ie after idle timeout)
# See: https://www.tenforums.com/tutorials/158033-change-time-require-sign-after-display-turns-off-windows-10-a.html
Remove-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name DelayLockInterval -Verbose

# Move taskbar to the left
# https://www.elevenforum.com/t/change-taskbar-alignment-in-windows-11.12/
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'TaskbarAl'

# Remove widgets from lock screen
# https://www.elevenforum.com/t/enable-or-disable-widgets-on-lock-screen-in-windows-11.33140/
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Lock Screen' -Value 0 -Name 'LockScreenWidgetsEnabled'

# Remove widgets from taskbar
# https://www.elevenforum.com/t/add-or-remove-widgets-button-on-taskbar-in-windows-11.32/#Two
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'TaskbarDa'
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f

# Disable 'please make a windows account' bullshit
# https://www.elevenforum.com/t/enable-or-disable-notification-badging-for-microsoft-accounts-on-start-menu-in-windows-11.14645/
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'Start_AccountNotifications'








#-----------------
# NEED ADMIN
# Disable the retarded notification "Could Not Reconnect All Network Drives", which is a fucking lie, Microsoft
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider' -Value 0 -Name 'RestoreConnection'

# Disable some windows Activity tracker
# https://www.elevenforum.com/t/enable-or-disable-store-activity-history-on-device-in-windows-11.7812/
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Value 0 -Name 'PublishUserActivities'

# Remove Home from Windows Explorer
# https://www.elevenforum.com/t/add-or-remove-home-in-navigation-pane-of-file-explorer-in-windows-11.2449/
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" -Name "HiddenByDefault" -Value 1 -Type DWord

# Remove Gallery from Windows Explorer
# https://www.elevenforum.com/t/add-or-remove-gallery-in-file-explorer-navigation-pane-in-windows-11.14178/
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Name "HiddenByDefault" -Value 1 -Type DWord

# Enable long paths
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Value 1 -Name 'LongPathsEnabled'






#-----------------
# Create shortcuts for autostart
# Note, i cannot create shortcuts to taskbar, even as admin. No idea why, they just dont show up
function mkShortcut($folder, $fileName, $targetPath, $arguments)
{
    $s = (New-Object -COM WScript.Shell).CreateShortcut("$folder\$fileName.lnk")
    $s.TargetPath = $targetPath
    $s.Arguments = '"' + ($arguments -join '" "') + '"'
    $s.WorkingDirectory = Split-Path $targetPath
    $s.Save()
}

$StartUPFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
$StartUpLocalUserFolder = "C:\Users\TheBestPessimist\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
$StartFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"


mkShortcut $StartUPLocalUserFolder "AutoHotkey64.ahk" "D:\all\all\AutoHotkey\AutoHotkey64.ahk"
mkShortcut $StartUPLocalUserFolder "Flow.Launcher.exe" "D:\all\all\FlowLauncher\Flow.Launcher.exe"
mkShortcut $StartUPLocalUserFolder "ShareX.exe" "D:\all\all\ShareX-portable\ShareX.exe"
mkShortcut $StartUPLocalUserFolder "Telegram.exe" "D:\all\all\Telegram\Telegram.exe"
mkShortcut $StartUPLocalUserFolder "AltSnap.exe" "D:\all\all\AltSnap\AltSnap.exe"


# $PageAntKeys = (Get-ChildItem "$env:USERPROFILE\.ssh\" -Filter *.ppk).FullName
# mkShortcut $StartUPFolder "PageAnt.exe" "D:\all\all\PortableApps\PortableApps\PuTTYPortable\App\putty\PAGEANT.EXE" $PageAntKeys
#
# mkShortcut $StartFolder "JDownloader2.exe" "D:\all\all\JDownloader v2.0\JDownloader2.exe"


#-----------------
# Unpin folders from explorer quick access
# https://stackoverflow.com/a/46357909/2161279
function unpinFromExplorer($folderPath)
{
    $qa = New-Object -ComObject shell.application
    ($qa.Namespace("shell:::{679F85CB-0220-4080-B29B-5540CC05AAB6}").Items() | Where-Object { $_.Path -EQ $folderPath }).InvokeVerb("unpinfromhome")
}

unpinFromExplorer "C:\Users\${env:USERNAME}\Documents"
unpinFromExplorer "C:\Users\${env:USERNAME}\Pictures"
unpinFromExplorer "C:\Users\${env:USERNAME}\Music"
unpinFromExplorer "C:\Users\${env:USERNAME}\Videos"




#-----------------

# Manual stuff

restore windows terminal settings

make autostart
- ghelper (run as admin to create the scheduled task)
- everything + everything service

add taskbar shortcut to
- mediamonkey
- sublime text

# Create the network shares
# ❗ NOT As admin ❗

# first go in explorer here and save passwords
\\tbp-nuc
\\roxanas-mbp

New-PSDrive -Persist -Scope Global -Verbose -Name "P" -Root "\\tbp-nuc\patrunjel\Patrunjel\Patrunjel" -PSProvider "FileSystem"
New-PSDrive -Persist -Scope Global -Verbose -Name "T" -Root "\\tbp-nuc\torrentz" -PSProvider "FileSystem"
New-PSDrive -Persist -Scope Global -Verbose -Name "W" -Root "\\tbp-nuc\tbp" -PSProvider "FileSystem"
New-PSDrive -Persist -Scope Global -Verbose -Name "Z" -Root "\\roxanas-mbp\pokambrian" -PSProvider "FileSystem"
