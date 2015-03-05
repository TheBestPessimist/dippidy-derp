## Mirror folder trees with robocopy

````
robocopy [src] [dest] /MIR /Z  /R:0 /W:5 /MT /XJ /LOG:a.txt


/MIR : MIRror a directory tree - equivalent to /PURGE plus all subfolders (/E) (will also delete!)
/Z : Copy files in restartable mode (survive network glitch).
/R:n : Number of Retries on failed copies - default is 1 million.
/W:n : Wait time between retries - default is 30 seconds.
/MT[:n] : Multithreaded copying, n = no. of threads to use (1-128), default 8
/XJ : eXclude Junction points. (normally included by default). (exclude symlinks?)

````


## Find the current proxy settings of a browser

- [http://wpad/wpad.dat](http://wpad/wpad.dat)
- [http://superuser.com/questions/33588/how-to-view-internet-explorer-auto-detected-proxy-settings](http://superuser.com/questions/33588/how-to-view-internet-explorer-auto-detected-proxy-settings)
- [http://en.wikipedia.org/wiki/Web_Proxy_Autodiscovery_Protocol](http://en.wikipedia.org/wiki/Web_Proxy_Autodiscovery_Protocol)


## Get the link to the latest version of a file on Bitbucket

- for a git repo use `master` instead of the sha1 of that file
	- random commit: [https://bitbucket.org/thebestpessimist/dippidy-derp/src/67da08316b7bc35afc787808b8770ce65c4ca4f8/random.md?at=master](https://bitbucket.org/thebestpessimist/dippidy-derp/src/67da08316b7bc35afc787808b8770ce65c4ca4f8/random.md?at=master)
	- master commit: [https://bitbucket.org/thebestpessimist/dippidy-derp/src/master/random.md](https://bitbucket.org/thebestpessimist/dippidy-derp/src/master/random.md)
	
- for a mecurial repo use `tip` instead of the id of that file.