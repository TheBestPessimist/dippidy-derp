# Scripts and command to make windows 10 a little bit more user-friendly
# Run this as admin

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
Get-Service XblAuthManager,XblGameSave,XboxNetApiSvc -erroraction silentlycontinue | stop-service -passthru | set-service -startuptype disabled


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
    "Microsoft.WindowsPhone"
)
Get-AppxProvisionedPackage -Online | where-object {$_.DisplayName -in $appsToRemove } | Remove-AppxProvisionedPackage -Online


# Autologin windows
# Ref: https://www.lifewire.com/how-do-i-auto-login-to-windows-2626066
netplwiz


