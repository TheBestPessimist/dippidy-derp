# Scripts and command to make windows 10 a little bit more user-friendly
# Run this as admin

# Open windows explorer to "My PC" instead of "recents"
# https://superuser.com/questions/819521/how-do-i-make-windows-10s-file-explorer-open-this-pc-by-default
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\' -Value 1 -Name 'LaunchTo'



# Never combine application's buttons
# https://superuser.com/questions/135015/set-never-combine-in-windows-7-using-the-registry
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\' -Value 2 -Name 'TaskbarGlomLevel'



# It is rumored that remote differential compression slows stuff down. Who knows?
# https://www.trishtech.com/2010/08/turn-off-remote-differential-compression-in-windows-7/
DISM /online /disable-feature /FeatureName:MSRDC-Infrastructure


#Disable xBox services - "xBox Game Monitoring Service" - XBGM - Can't be disabled (access denied)
Get-Service XblAuthManager,XblGameSave,XboxNetApiSvc -erroraction silentlycontinue | stop-service -passthru | set-service -startuptype disabled


# Disable some windows Activity tracker
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System\' -Value 0 -Name 'PublishUserActivities'
