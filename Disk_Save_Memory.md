# Reduce journald log

You can tell Ubuntu to never let the logs exceed a certain size.

Open the configuration file:
```
sudo vim /etc/systemd/journald.conf
```

Find the line #SystemMaxUse= (it’s usually commented out with a #).

Uncomment it and set your limit. For example, to cap it at 500MB
```
SystemMaxUse=500M
```

Save and exit.

Restart the service to apply the changes:

```
sudo systemctl restart systemd-journald
```
