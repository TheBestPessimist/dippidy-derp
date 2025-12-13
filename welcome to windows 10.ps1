
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
"Microsoft.DesktopAppInstaller",
"Microsoft.Getstarted",
"Microsoft.People",
"Microsoft.windowscommunicationsapps",
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

"Microsoft.Xbox.TCUI",
"Microsoft.XboxApp",
"Microsoft.XboxGameOverlay",
"Microsoft.XboxGamingOverlay",
"Microsoft.XboxIdentityProvider",
"Microsoft.XboxSpeechToTextOverlay",
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
