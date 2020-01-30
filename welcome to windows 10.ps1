function mkShortcut($folder, $fileName, $targetPath, $arguments)
{
    $s = (New-Object -COM WScript.Shell).CreateShortcut("$folder\$fileName.lnk")
    $s.TargetPath = $targetPath
    $s.Arguments = '"' + ($keys -join '" "') + '"'
    $s.WorkingDirectory = Split-Path $targetPath
    $s.Save()
}


function replaceScheduledTask($scheduledTaskName, $programToExecute)
{
    Unregister-ScheduledTask -TaskName $scheduledTaskName -Confirm: $false -ErrorAction SilentlyContinue

    $task = New-ScheduledTaskAction -Execute $programToExecute
    $trigger = New-ScheduledTaskTrigger -AtLogon
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -MultipleInstances IgnoreNew
    $principal = New-ScheduledTaskPrincipal -GroupId 'Users' -RunLevel Highest

    $scheduledTaskParameters = @{
        TaskName = $scheduledTaskName
        Action = $task
        Trigger = $trigger
        Principal = $principal
        Settings = $settings
    }
    Register-ScheduledTask @scheduledTaskParameters
}


# Source: https://superuser.com/a/1442733/206341
function fuckYouMicrosoft()
{
    #Delete layout file if it already exists
    If (Test-Path C:\Windows\StartLayout.xml)
    {
        Remove-Item C:\Windows\StartLayout.xml
    }

    #Creates the blank layout file
    echo "<LayoutModificationTemplate xmlns:defaultlayout=""http://schemas.microsoft.com/Start/2014/FullDefaultLayout"" xmlns:start=""http://schemas.microsoft.com/Start/2014/StartLayout"" Version=""1"" xmlns=""http://schemas.microsoft.com/Start/2014/LayoutModification"">" >> C:\Windows\StartLayout.xml
    echo "  <LayoutOptions StartTileGroupCellWidth=""6"" />" >> C:\Windows\StartLayout.xml
    echo "  <DefaultLayoutOverride>" >> C:\Windows\StartLayout.xml
    echo "    <StartLayoutCollection>" >> C:\Windows\StartLayout.xml
    echo "      <defaultlayout:StartLayout GroupCellWidth=""6"" />" >> C:\Windows\StartLayout.xml
    echo "    </StartLayoutCollection>" >> C:\Windows\StartLayout.xml
    echo "  </DefaultLayoutOverride>" >> C:\Windows\StartLayout.xml
    echo "</LayoutModificationTemplate>" >> C:\Windows\StartLayout.xml

    $regAliases = @("HKLM", "HKCU")

    #Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
    foreach ($regAlias in $regAliases)
    {
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer"
        IF (!(Test-Path -Path $keyPath))
        {
            New-Item -Path $basePath -Name "Explorer"
        }
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
        Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value "C:\Windows\StartLayout.xml"
    }

    #Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
    Stop-Process -name explorer
    Start-Sleep -s 5
    $wshell = New-Object -ComObject wscript.shell;$wshell.SendKeys('^{ESCAPE}')
    Start-Sleep -s 5

    #Enable the ability to pin items again by disabling "LockedStartLayout"
    foreach ($regAlias in $regAliases)
    {
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer"
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
    }

    #Restart Explorer and delete the layout file
    Stop-Process -name explorer
    Remove-Item C:\Windows\StartLayout.xml
}

# Source: https://stackoverflow.com/a/46357909/2161279
function unpinFromExplorer($folderPath)
{
    $qa = New-Object -ComObject shell.application
    ($qa.Namespace("shell:::{679F85CB-0220-4080-B29B-5540CC05AAB6}").Items() | Where-Object { $_.Path -EQ $folderPath }).InvokeVerb("unpinfromhome")
}



# Scripts and command to make windows 10 a little bit more user-friendly
# Run this as admin

# needed for stuffs
taskkill /f /im explorer.exe


# Open windows explorer to "My PC" instead of "recents"
# https://superuser.com/questions/819521/how-do-i-make-windows-10s-file-explorer-open-this-pc-by-default
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\' -Value 1 -Name 'LaunchTo'


# Never combine application's buttons
# https://superuser.com/questions/135015/set-never-combine-in-windows-7-using-the-registry
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\' -Value 2 -Name 'TaskbarGlomLevel'


# Show Files extensions
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\' -Value 0 -Name 'HideFileExt'

# Show hidden files
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 1 -Name 'Hidden'


# It is rumored that remote differential compression slows stuff down. Who knows?
# https://www.trishtech.com/2010/08/turn-off-remote-differential-compression-in-windows-7/
DISM /online /disable-feature /FeatureName:MSRDC-Infrastructure


# Disable xBox services - "xBox Game Monitoring Service" - XBGM - Can't be disabled (access denied)
Get-Service XblAuthManager, XblGameSave, XboxNetApiSvc -erroraction silentlycontinue | stop-service -passthru | set-service -startuptype disabled


# Disable some windows Activity tracker
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System\' -Value 0 -Name 'PublishUserActivities'

# Disable Windows Welcome Experience
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-310093Enabled'

# Disable Windows Get tips, tricks, and suggestions as you use Windows
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-338389Enabled'

# Disable Windows Snap Assist (show what can be snapped next to this window)
# Ref: https://www.tenforums.com/tutorials/4343-turn-off-snap-windows-windows-10-a.html#option3
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'SnapAssist'

# Disable AutoPlay of USB devices
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Value 1 -Name 'DisableAutoplay'

# Disable app suggestions from Start menu
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-338388Enabled'

# Disallow windows to update over metered networks
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 0 -Name 'AllowAutoWindowsUpdateDownloadOverMeteredNetwork'

# Hide Cortana crap taskbar button and search bar
# Hide Task View taskbar button
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Value 0 -Name 'SearchboxTaskbarMode'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'ShowCortanaButton'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Value 0 -Name 'ShowTaskViewButton'



# Set working hours to as much as possible so that windows won't try to update or restart
# Start @ 7:00 AM
# End   @ 1:00 AM (18 hours)
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 7 -Name 'ActiveHoursStart'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 1 -Name 'ActiveHoursEnd'

# Delay updates as much as possible, and notify about them
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 365 -Name 'DeferFeatureUpdatesPeriodInDays'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 30 -Name 'DeferQualityUpdatesPeriodInDays'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 0 -Name 'ExcludeWUDriversInQualityUpdate'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 1 -Name 'RestartNotificationsAllowed2'


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





# Uninstall some "Modern Apps"
# Ref: https://blog.danic.net/how-windows-10-pro-installs-unwanted-apps-candy-crush-and-how-you-stop-it/
$appsToRemove = @(
"Microsoft.3DBuilder",
"Microsoft.Appconnector",
"Microsoft.BingFinance",
"Microsoft.BingNews",
"Microsoft.DesktopAppInstaller",
"Microsoft.Getstarted",
"Microsoft.Messaging",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.MicrosoftStickyNotes",
"Microsoft.Office.OneNote",
"Microsoft.Office.Sway",
"Microsoft.OneConnect",
"Microsoft.People",
"Microsoft.SkypeApp",
"Microsoft.windowscommunicationsapps",
"Microsoft.MicrosoftSolitaireCollection"
"Microsoft.MixedReality.Portal",
"Microsoft.YourPhone",
"7EE7776C.LinkedInforWindows",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxApp",
"Microsoft.XboxGameOverlay",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay",
"Microsoft.WindowsPhone"
)
Get-AppxProvisionedPackage -Online | where-object { $_.DisplayName -in $appsToRemove } | Remove-AppxProvisionedPackage -Online



$appsToRemove = @(
"7EE7776C.LinkedInforWindows",
"Microsoft.MicrosoftOfficeHub",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.MicrosoftStickyNotes",
"Microsoft.Office.OneNote",
"Microsoft.SkypeApp",
"Microsoft.WindowsMaps",
"Microsoft.Xbox.TCUI",
"Microsoft.XboxApp",
"Microsoft.XboxGameOverlay",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay",
"king.com.CandyCrushSaga"
)
foreach ($app in $appsToRemove)
{
    Remove-AppxPackage (Get-AppxPackage $app).PackageFullName
}


# Uninstall OneDrive
taskkill /f /im OneDrive.exe
taskkill /f /im explorer.exe

sleep 5

& "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall

sleep 5

Remove-Item -Force -Recurse "$env:USERPROFILE\OneDrive"
Remove-Item -Force -Recurse  "C:\OneDriveTemp"
Remove-Item -Force -Recurse  "$env:LOCALAPPDATA\Microsoft\OneDrive"
Remove-Item -Force -Recurse  "$env:ProgramData\Microsoft OneDrive"



# Associate .ahk with AutoHotkey Files
cmd /c 'assoc .ahk="AutoHotkey File"'
cmd /c 'Ftype "AutoHotkey File"="C:\all\AutoHotkey\AutoHotkeyU64.exe" %1'


# Create shortcuts
$GlobalStartupFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
# $UserStartupFolder = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$GlobalStartFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"


mkShortcut $GlobalStartupFolder "AutoHotkeyU64.ahk" "C:\all\AutoHotkey\AutoHotkeyU64.ahk"
mkShortcut $GlobalStartupFolder "Launcher.ahk" "C:\all\AutoHotKey-Launcher\Launcher.ahk"
mkShortcut $GlobalStartFolder "JDownloader2.exe" "C:\all\JDownloader v2.0\JDownloader2.exe"
mkShortcut $GlobalStartupFolder "ShareX.exe" "C:\all\ShareX-portable\ShareX.exe"
$PageAntKeys = (Get-ChildItem "$env:USERPROFILE\.ssh\" -Filter *.ppk).FullName
mkShortcut $UserStartupFolder "PageAnt.exe" "C:\all\PortableApps\PortableApps\PuTTYPortable\App\putty\PAGEANT.EXE" $PageAntKeys


# Set default power actions

# Hibernate when power button pressed
# Ref: https://www.tenforums.com/tutorials/69741-change-default-action-power-button-windows-10-a.html#option3
# powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 2
# powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 2

# Do nothing on lid close
# Ref: https://www.tenforums.com/tutorials/69762-change-lid-close-default-action-windows-10-a.html
# powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
# powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0

# Do nothing when sleep button
# powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0
# powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0


# Ignore some folders in windows defender
Add-MpPreference -ExclusionPath "C:\work-metas\"
Add-MpPreference -ExclusionPath "C:\work\"
Add-MpPreference -ExclusionPath "$env:USERPROFILE\AppData\Local\JetBrains"




# Make start menu and taskbar decent
fuckYouMicrosoft


# Disable the retarded notification "Could Not Reconnect All Network Drives", which is a fucking lie, Microsoft
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider' -Value 0 -Name 'RestoreConnection'




# Restart explorer
explorer.exe


# Unpin folders from explorer quick access
unpinFromExplorer "C:\Users\${env:USERNAME}\Documents"
unpinFromExplorer "C:\Users\${env:USERNAME}\Pictures"
unpinFromExplorer "C:\Users\${env:USERNAME}\Music"
unpinFromExplorer "C:\Users\${env:USERNAME}\Videos"

# Create ThrottleStop scheduledTask
$taskName = "Throttle Stop"
$programPath = "C:\all\ThrottleStop\ThrottleStop.exe"
replaceScheduledTask $taskName $programPath



# Time and date format
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name iFirstDayOfWeek -Value "0";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortDate -Value "dddd, d MMMM, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortTime -Value "HH:mm";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sLongDate -Value "dddd, d MMMM, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sTimeFormat -Value "HH:mm:ss";


$culture = Get-Culture
$culture.DateTimeFormat.ShortDatePattern = 'd/MM/yyyy'
$culture.DateTimeFormat.FirstDayOfWeek = 'Monday'
$culture.DateTimeFormat.ShortDatePattern = 'dddd, d MMMM, yyyy'
$culture.DateTimeFormat.ShortTimePattern = 'HH:mm'
$culture.DateTimeFormat.LongDatePattern = 'dddd, d MMMM, yyyy'
Set-Culture $culture

# because of some unknown reason, ShortTimePattern is wrong and i have to set it from registry
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortTime -Value "HH:mm";


# Restart explorer
explorer.exe


# Disable sound ducking in sound settings -> communications
# https://www.sevenforums.com/tutorials/13210-system-sounds-auto-leveling-disable.html

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name UserDuckingPreference -Value 3;



# Autologin windows
# Ref: https://www.lifewire.com/how-do-i-auto-login-to-windows-2626066
netplwiz

