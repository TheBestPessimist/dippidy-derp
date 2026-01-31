<#

possibly useful to restore the power plans
https://www.elevenforum.com/t/restore-missing-power-plans-in-windows-11.6898/



Power config
https://jakubjares.com/2018/11/08/powercfg/
https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/update-power-settings

interesting commands:
powercfg -query
powercfg -qh (MUCH more details than the above command)
powercfg -aliasesh

DC means on battery (setdcvalueindex)
AC means on charger (setacvalueindex)


Maybe this command is enough to disable the fucking modern standby:
- https://www.elevenforum.com/t/disable-modern-standby-in-windows-10-and-windows-11.3929/
- https://learn.microsoft.com/en-us/previous-versions/windows/iot-core/learn-about-hardware/wakeontouch#disabling-modern-standby

reg add HKLM\System\CurrentControlSet\Control\Power /v PlatformAoAcOverride /t REG_DWORD /d 0


#>









# Enable adaptive display idle timeout (adaptive time for the idle timeout above)
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/display-settings-adaptive-display-idle-timeout
powercfg -setdcvalueindex SCHEME_ALL SUB_VIDEO VIDEOADAPT 1
powercfg -setacvalueindex SCHEME_ALL SUB_VIDEO VIDEOADAPT 1


# Possibly interesting setting: Prompt for password on resume from sleep
# Default is yes and i think i agree
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/no-subgroup-settings-prompt-for-password-on-resume

# This might be an interesting one:
# https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/sleep-settings-allow-sleep-states?source=recommendations
