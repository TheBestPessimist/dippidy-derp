# Understanding commands
```
help [command]
get-command   *-string
get-command  get-a*
alias echo
```


# misc
```
Get-ItemProperty HKCU:\AppEvents\Schemes\

(Get-Item C:\Windows) | Get-Member  // shows all the things i can access for this particular item(eg: (Get-Item C:\Windows).FullName)

newline = `n
```

# Use default proxy settings

```
[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()
[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

Invoke-WebRequest https://google.com
```
