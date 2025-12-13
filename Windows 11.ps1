# update path - i think i need to restart after this
<#
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;D:\all\all\PortableGit\bin"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

# set java path
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\live")
#>












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







do this:
https://www.elevenforum.com/t/enable-or-disable-notification-badging-for-microsoft-accounts-on-start-menu-in-windows-11.14645/
