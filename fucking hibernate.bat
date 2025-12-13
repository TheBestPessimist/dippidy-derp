@echo off
set TIMERLOG="%USERPROFILE%\Desktop\waketimers.log"
echo[ >>%TIMERLOG%
echo ================================================================= >>%TIMERLOG%
echo ** HIBERNATION INITIATED AT: %date% %time% >>%TIMERLOG%
echo ** LIST OF CURRENTLY SET WAKE TIMERS: >>%TIMERLOG%
powercfg /waketimers >>%TIMERLOG%
if errorlevel 1 goto error
shutdown /h
ping 127.0.0.1 -n 6 > nul
echo[ >>%TIMERLOG%
echo ** RESUMED AT: %date% %time% >>%TIMERLOG%
echo ** WAKE REASON WAS: >>%TIMERLOG%
powercfg /lastwake >>%TIMERLOG%
echo[ >>%TIMERLOG%
goto end
:error
echo ERROR: Can't query wake timers >>%TIMERLOG%
echo Unable to query wake timers. Make sure this batch is running with Administrator privileges!
pause
goto end
:end
