if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
{
    $script = $MyInvocation.PSCommandPath
    echo "Run $script"
    Start-Process pwsh -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$script`" " -Verb RunAs -Wait
    exit # for some reason, this 'exit' doesn't work
}
