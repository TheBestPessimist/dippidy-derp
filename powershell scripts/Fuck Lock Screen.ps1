<#
Disable Lock Screen after screen is simply turned off (ie after idle timeout)
See: https://www.tenforums.com/tutorials/158033-change-time-require-sign-after-display-turns-off-windows-10-a.html

Unfortunately I have to make this script because windows is fucking retarded and recreates the Property after <something> happens.
Why? Fuck knows.
I swear man, every new windows version has more retarded changes, just to have some retarded changes written to the changelog.
#>
. "./Run As Admin.ps1"

Remove-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name DelayLockInterval -Verbose

pause
