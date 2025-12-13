

# Create shortcuts
function mkShortcut($folder, $fileName, $targetPath, $arguments)
{
    $s = (New-Object -COM WScript.Shell).CreateShortcut("$folder\$fileName.lnk")
    $s.TargetPath = $targetPath
    $s.Arguments = '"' + ($arguments -join '" "') + '"'
    $s.WorkingDirectory = Split-Path $targetPath
    $s.Save()
}

$StartUPFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
$StartUpLocalUserFolder = "C:\Users\TheBestPessimist\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
$StartFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs"


mkShortcut $StartUPLocalUserFolder "AutoHotkey64.ahk" "D:\all\all\AutoHotkey\AutoHotkey64.ahk"
mkShortcut $StartUPLocalUserFolder "Launcher.exe" "D:\all\all\AutoHotKey-Launcher\Launcher.exe" "D:\all\all\AutoHotKey-Launcher\Launcher.ahk"
mkShortcut $StartUPLocalUserFolder "Flow.Launcher.exe" "D:\all\all\Flow.Launcher\Flow.Launcher.exe"
mkShortcut $StartUPLocalUserFolder "ShareX.exe" "D:\all\all\ShareX-portable\ShareX.exe"
# $PageAntKeys = (Get-ChildItem "$env:USERPROFILE\.ssh\" -Filter *.ppk).FullName
# mkShortcut $StartUPFolder "PageAnt.exe" "D:\all\all\PortableApps\PortableApps\PuTTYPortable\App\putty\PAGEANT.EXE" $PageAntKeys

mkShortcut $StartFolder "JDownloader2.exe" "D:\all\all\JDownloader v2.0\JDownloader2.exe"









# update path - i think i need to restart after this
<#
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;D:\all\all\PortableGit\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

# set java path
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\live")
#>





enable long paths:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem\LongPathsEnabled set to 1.




# Disable Lock Screen after screen is simply turned off (ie after idle timeout)
# See: https://www.tenforums.com/tutorials/158033-change-time-require-sign-after-display-turns-off-windows-10-a.html
Remove-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name DelayLockInterval -Verbose







# Unpin folders from explorer quick access

# Source: https://stackoverflow.com/a/46357909/2161279
function unpinFromExplorer($folderPath)
{
    $qa = New-Object -ComObject shell.application
    ($qa.Namespace("shell:::{679F85CB-0220-4080-B29B-5540CC05AAB6}").Items() | Where-Object { $_.Path -EQ $folderPath }).InvokeVerb("unpinfromhome")
}


unpinFromExplorer "C:\Users\${env:USERNAME}\Documents"
unpinFromExplorer "C:\Users\${env:USERNAME}\Pictures"
unpinFromExplorer "C:\Users\${env:USERNAME}\Music"
unpinFromExplorer "C:\Users\${env:USERNAME}\Videos"



stop-process -name explorer –force













# Create the network shares
# ❗ NOT As admin ❗ 

# first go in explorer here and save passwords
\\tbp-nuc
\\roxanas-mbp

New-PSDrive -Persist -Scope Global -Verbose -Name "P" -Root "\\tbp-nuc\patrunjel\Patrunjel\Patrunjel" -PSProvider "FileSystem" 
New-PSDrive -Persist -Scope Global -Verbose -Name "T" -Root "\\tbp-nuc\torrentz" -PSProvider "FileSystem" 
New-PSDrive -Persist -Scope Global -Verbose -Name "W" -Root "\\tbp-nuc\tbp" -PSProvider "FileSystem" 
New-PSDrive -Persist -Scope Global -Verbose -Name "X" -Root "\\tbp-nuc\torrentza" -PSProvider "FileSystem" 
New-PSDrive -Persist -Scope Global -Verbose -Name "Z" -Root "\\roxanas-mbp\pokambrian" -PSProvider "FileSystem" 







# Manual stuff

restore windows terminal settings

make autostart
- ghelper
- telegram
- alt snap
- everything + everything service


add taskbar shortcut to
- mediamonkey

do this:
https://www.elevenforum.com/t/enable-or-disable-notification-badging-for-microsoft-accounts-on-start-menu-in-windows-11.14645/
