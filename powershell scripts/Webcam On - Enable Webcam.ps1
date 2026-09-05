. ./Elevate.ps1

 Get-PnpDevice -FriendlyName "USB2.0 FHD UVC WebCam" | Enable-PnpDevice -Confirm:$false



# Why these 2 scripts? BECAUSE Windows Hello/Face Unlock/Face Sign In is FUCKING SLOW and no longer works in the dark due to KB5055523.
# FUCK YOU MICROSHITSOFT
