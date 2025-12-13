
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







# Disable some windows Activity tracker
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System\' -Value 0 -Name 'PublishUserActivities'

# Disable Windows Welcome Experience
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-310093Enabled'

# Disable Windows Get tips, tricks, and suggestions as you use Windows
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Value 0 -Name 'SubscribedContent-338389Enabled'






# Delay updates as much as possible, and notify about them
# Note, there are a log of interesting keys here which maybe it makes sense to preserve
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 365 -Name 'DeferFeatureUpdatesPeriodInDays'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 30 -Name 'DeferQualityUpdatesPeriodInDays'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 0 -Name 'ExcludeWUDriversInQualityUpdate'
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Value 1 -Name 'RestartNotificationsAllowed2'








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






# Autologin windows
# Ref: https://www.lifewire.com/how-do-i-auto-login-to-windows-2626066
netplwiz
