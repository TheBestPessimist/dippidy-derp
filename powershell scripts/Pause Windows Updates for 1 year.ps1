. ./Elevate.ps1

# Enable Pausing Windows Updates for 1400 days, then go to settings and chose the pause period
# https://www.elevenforum.com/t/change-maximum-days-to-pause-windows-update-in-windows-11.9202/
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name FlightSettingsMaxPauseDays -Value 1400

# Actually Pause Windows Updates
# https://www.elevenforum.com/t/pause-and-resume-updates-for-windows-11.447/#Three
# Make this a multiple of 7
$numberOfDaysToPause = 7 * 50

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\Settings" -Name PausedFeatureStatus -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\Settings" -Name PausedQualityStatus -Value 1

$daysInTheFuture = (Get-Date).AddDays($numberOfDaysToPause).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssK")
$now = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssK")

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name  PauseFeatureUpdatesStartTime -Value "$now"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name  PauseFeatureUpdatesEndTime -Value "$daysInTheFuture"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name  PauseQualityUpdatesStartTime -Value "$now"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name  PauseQualityUpdatesEndTime -Value "$daysInTheFuture"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name  PauseUpdatesStartTime -Value "$now"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name  PauseUpdatesExpiryTime -Value "$daysInTheFuture"

echo "Updates paused until $daysInTheFuture, total = $numberOfDaysToPause days"


pause
