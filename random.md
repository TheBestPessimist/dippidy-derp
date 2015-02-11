- #### Mirror folder trees with robocopy

````
robocopy [src] [dest] /MIR /Z  /R:0 /W:5 /MT /XJ /LOG:a.txt


/MIR : MIRror a directory tree - equivalent to /PURGE plus all subfolders (/E) (will also delete!)
/Z : Copy files in restartable mode (survive network glitch).
/R:n : Number of Retries on failed copies - default is 1 million.
/W:n : Wait time between retries - default is 30 seconds.
/MT[:n] : Multithreaded copying, n = no. of threads to use (1-128), default 8
/XJ : eXclude Junction points. (normally included by default). (exclude symlinks?)

````