if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
{
    $script = $MyInvocation.PSCommandPath
    echo "Running script  $script"
    echo ""
    echo "Waiting for elevated process to finish..."
    Start-Process pwsh -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$script`" " -Verb RunAs -Wait
    # See info about exit here: https://stackoverflow.com/a/67642758/2161279
    [Environment]::Exit(0)
}
