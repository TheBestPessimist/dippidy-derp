If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}
$netw = netsh wlan show hostednetwork
if ($netw.Get($netw.Count - 2 ).toLower().contains("not") ) {
    netsh wlan set hostednetwork mode=allow SSID="Le Epic" key="qwertyui"
    netsh wlan start hostednetwork
}
else {
    netsh wlan stop hostednetwork
}
