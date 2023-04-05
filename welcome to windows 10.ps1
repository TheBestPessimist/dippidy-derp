
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



# Scripts and command to make windows 10 a little bit more user-friendly
# Run this as admin

# needed for stuffs
taskkill /f /im explorer.exe




# Never combine application's buttons
# https://superuser.com/questions/135015/set-never-combine-in-windows-7-using-the-registry
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\' -Value 2 -Name 'TaskbarGlomLevel'





# Disable some windows Activity tracker
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System\' -Value 0 -Name 'PublishUserActivities'

# Disable Windows Welcome Experience
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-310093Enabled'

# Disable Windows Get tips, tricks, and suggestions as you use Windows
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-338389Enabled'



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
# Note, there are a log of interesting keys here which maybe it makes sense to preserve
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





# Disable the retarded notification "Could Not Reconnect All Network Drives", which is a fucking lie, Microsoft
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider' -Value 0 -Name 'RestoreConnection'


# todo disable focus assist.

# Restart explorer
explorer.exe



# Create ThrottleStop scheduledTask
$taskName = "Throttle Stop"
$programPath = "C:\all\ThrottleStop\ThrottleStop.exe"
replaceScheduledTask $taskName $programPath



$culture = Get-Culture
$culture.DateTimeFormat.ShortDatePattern = 'dddd, d MMMM, yyyy'
$culture.DateTimeFormat.FirstDayOfWeek = 'Monday'
$culture.DateTimeFormat.ShortDatePattern = 'dddd, d MMMM, yyyy'
$culture.DateTimeFormat.ShortTimePattern = 'HH:mm'
$culture.DateTimeFormat.LongDatePattern = 'dddd, d MMMM, yyyy'
Set-Culture $culture

# beacause of some unknown reason, this needs o be run again. it's copy pasta from above
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name iFirstDayOfWeek -Value "0";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortDate -Value "dddd, d MMMM, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortTime -Value "HH:mm";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sLongDate -Value "dddd, d MMMM, yyyy";
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sTimeFormat -Value "HH:mm:ss";


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
