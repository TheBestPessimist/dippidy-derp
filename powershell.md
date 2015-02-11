````
get-childitem
get-content
get-item
get-itemproperty
SET-......  
get-help [command]
Get-ItemProperty HKCU:\AppEvents\Schemes\
Get-ItemProperty HKCU:\AppEvents\Schemes\ | item-list
 (Get-Item C:\Windows) | Get-Member  // shows all the things i can access for this particular item(eg: (Get-Item C:\Windows).fullname)
write-host / echo => output stuff
iex = invoke-expression
newline = `n

(Get-ItemProperty $path).tibi = i have a string named "tibi" in a key. this is how i get it's value
(Set-ItemProperty $path -name tibi -value 852) = i have a string named "tibi" in a key, this is how i set its value



get-command   *-vmswitch
get-command  get-a*






restart-service SharedAccess

````