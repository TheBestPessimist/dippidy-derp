. ./Elevate.ps1

# intel DSA autostart:
# https://www.elevenforum.com/t/intel-driver-support-assistant-disabling-from-startup.6461/
#
# PS C:\Users\TheBestPessimist> Get-Service *dsa*
#
# Status   Name               DisplayName
# ------   ----               -----------
# Stopped  DSAService         Intel(R) Driver & Support Assistant
# Stopped  DSAUpdateService   Intel(R) Driver & Support Assistant U…


# Start the service
Get-Service *dsa* | Start-Service
