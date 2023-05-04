Get-PnpDevice | Where-Object {$_.FriendlyName -like '*touch screen*'} | Enable-PnpDevice -Confirm:$false
