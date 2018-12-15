# Speed up browsing on network shares

Don't write .DS_Store files on netowrk shares.

Reference: https://support.apple.com/en-us/HT208209

`defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE`



# Turn off packet signing for SMB 2 and SMB 3 connections

Reference: https://support.apple.com/en-us/HT205926

```
sudo -s
echo "[default]" >> /etc/nsmb.conf
echo "signing_required=no" >> /etc/nsmb.conf
exit
```

# Create an alias for a network share

It seems this makes finder reconnect to a network share more easier. Who knows... mysterious are the mac ways..

Reference: https://superuser.com/questions/275621/osx-samba-how-do-i-automatically-remount-reconnect-to-drives-that-have-bee
