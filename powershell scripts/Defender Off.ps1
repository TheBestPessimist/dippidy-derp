# Get-MpPreference
#
# Ex: (Get-MpPreference).ExclusionPath
#
# https://learn.microsoft.com/en-us/powershell/module/defender/set-mppreference?view=windowsserver2022-ps
#
#
# DisableRealtimeMonitoring                     : False
# ExclusionPath                                 : {C:\Program Files\JetBrains\Rider\r2r,
#                                             C:\Users\TheBestPessimist\.gradle, C:\Users\TheBestPe
#                                             ssimist\.gradleC:\Users\TheBestPessimist\AppData\Loca
#                                             l\JetBrains\IntelliJIdea2023.1D:\all\work-nagarro\Rew
#                                             e Projects\billa-cz-CapacityEstimationService,
#                                             C:\Users\TheBestPessimist\.m2...}
#
#
#
#
# script to stop windows defender
#
# https://linuxhint.com/turn-off-real-time-protection-windows/#:~:text=From%20settings,%20navigate%20to%20the,time%20protection%20in%20windows%2010.
#
#
# and here:
# https://www.windowscentral.com/how-manage-microsoft-defender-antivirus-powershell-windows-10#:~:text=use%20these%20steps:-,Open%20Start.,path%20you%20want%20to%20exclude.
#
#
#
#
# name defender off

. ./Elevate.ps1

Set-MpPreference -DisableRealtimeMonitoring $true
