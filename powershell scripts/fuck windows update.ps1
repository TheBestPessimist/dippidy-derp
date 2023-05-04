# Source: https://ugetfix.com/ask/how-to-fix-language-pack-download-stuck-in-windows/

net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver


rm -recurse -force C:\Windows\System32\catroot2\*
rm -recurse -force C:\Windows\SoftwareDistribution\*

net start wuauserv
net start cryptSvc
net start bits
net start msiserver
