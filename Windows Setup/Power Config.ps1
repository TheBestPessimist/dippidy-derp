<#
Power config
https://jakubjares.com/2018/11/08/powercfg/
https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/update-power-settings

interesting commands:
- powercfg -query
- powercfg -qh (MUCH more details than the above command)
- powercfg -aliasesh
#>


# Disable auto brightness
# https://www.elevenforum.com/t/turn-on-or-off-content-adaptive-brightness-control-in-windows-11.2608/
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name DisableCABC -Value "1";


# Disable Modern Standby
# It's a piece of shit. Fuck this fucking shit. Whenever my screen turns off, laptop goes to sleep. This if fucking retarded
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Power" -Name PlatformAoAcOverride -Value 0
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Power" -Name CsEnabled -Value 0

# Enable Hibernate
powercfg /hibernate on

# Enable battery saver as soon as i unplug
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/battery-threshold
powercfg /setdcvalueindex SCHEME_ALL SUB_ENERGYSAVER ESBATTTHRESHOLD 100
powercfg /setacvalueindex SCHEME_ALL SUB_ENERGYSAVER ESBATTTHRESHOLD 100

# Turn off automatic display dimming on battery saver
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/brightness
powercfg /setdcvalueindex SCHEME_ALL SUB_ENERGYSAVER ESBRIGHTNESS 100
powercfg /setacvalueindex SCHEME_ALL SUB_ENERGYSAVER ESBRIGHTNESS 100

# Disable going to sleep. It fucks my laptop up.
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/sleep-settings-sleep-idle-timeout
powercfg -setdcvalueindex SCHEME_ALL SUB_SLEEP STANDBYIDLE 0
powercfg -setacvalueindex SCHEME_ALL SUB_SLEEP STANDBYIDLE 0

# Disable hybrid sleep
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/sleep-settings-hybrid-sleep
powercfg -setdcvalueindex SCHEME_ALL SUB_SLEEP HYBRIDSLEEP 0
powercfg -setacvalueindex SCHEME_ALL SUB_SLEEP HYBRIDSLEEP 0

# Hibernate after 30 min
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/sleep-settings-hibernate-idle-timeout
powercfg -setdcvalueindex SCHEME_ALL SUB_SLEEP HIBERNATEIDLE 1800
powercfg -setacvalueindex SCHEME_ALL SUB_SLEEP HIBERNATEIDLE 1800

# Do not allow any wake timers
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/sleep-settings-automatically-wake-for-tasks
powercfg -setdcvalueindex SCHEME_ALL SUB_SLEEP RTCWAKE 0
powercfg -setacvalueindex SCHEME_ALL SUB_SLEEP RTCWAKE 0

# Do nothing when lid is open
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/lid-open-wake-action
powercfg -setdcvalueindex SCHEME_ALL SUB_BUTTONS LIDOPENWAKE 0
powercfg -setacvalueindex SCHEME_ALL SUB_BUTTONS LIDOPENWAKE 0

# Do nothing when lid is closed
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/power-button-and-lid-settings-lid-switch-close-action
powercfg -setdcvalueindex SCHEME_ALL SUB_BUTTONS LIDACTION 0
powercfg -setacvalueindex SCHEME_ALL SUB_BUTTONS LIDACTION 0

# Hibernate on power button press
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/power-button-and-lid-settings-power-button-action
powercfg -setdcvalueindex SCHEME_ALL SUB_BUTTONS PBUTTONACTION 2
powercfg -setacvalueindex SCHEME_ALL SUB_BUTTONS PBUTTONACTION 2

# Hibernate on sleep button press
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/power-button-and-lid-settings-sleep-button-action
powercfg -setdcvalueindex SCHEME_ALL SUB_BUTTONS 96996bc0-ad50-47ec-923b-6f41874dd9eb 2
powercfg -setacvalueindex SCHEME_ALL SUB_BUTTONS 96996bc0-ad50-47ec-923b-6f41874dd9eb 2

# Turn off display after 3 min of idle
powercfg -setdcvalueindex SCHEME_ALL SUB_VIDEO VIDEOIDLE 180
powercfg -setacvalueindex SCHEME_ALL SUB_VIDEO VIDEOIDLE 180

# Enable adaptive display idle timeout (adaptive time for the idle timeout above)
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/display-settings-adaptive-display-idle-timeout
powercfg -setdcvalueindex SCHEME_ALL SUB_VIDEO VIDEOADAPT 1
powercfg -setacvalueindex SCHEME_ALL SUB_VIDEO VIDEOADAPT 1

# Disable adaptive brightness
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/display-settings-adaptive-display-idle-timeout
powercfg -setdcvalueindex SCHEME_ALL SUB_VIDEO ADAPTBRIGHT 0
powercfg -setacvalueindex SCHEME_ALL SUB_VIDEO ADAPTBRIGHT 0

# Possibly interesting setting: Prompt for password on resume from sleep
# Default is yes and i think i agree
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/no-subgroup-settings-prompt-for-password-on-resume



<#
Other things i've done to my Asus laptop:
https://answers.microsoft.com/en-us/insider/forum/all/windows-10-wakes-randomly-from-hibernate/247e69c3-cc7a-40db-b34e-43d8d60e6947?page=2

PS C:\Windows\System32> powercfg /devicequery wake_armed
HID-compliant mouse (002)
HID-compliant mouse (003)
HID Keyboard Device (003)
USB4(TM) Root Device Router (Microsoft)
HID Keyboard Device (004)


powercfg /DEVICEDISABLEWAKE 'HID-compliant mouse (002)'
powercfg /DEVICEDISABLEWAKE 'HID-compliant mouse (003)'
powercfg /DEVICEDISABLEWAKE 'HID Keyboard Device (003)'
powercfg /DEVICEDISABLEWAKE 'HID Keyboard Device (004)'
powercfg /DEVICEDISABLEWAKE 'USB4(TM) Root Device Router (Microsoft)'



#>
