# Detector
Detecting attacks on your linux host

## change the interval for lower/higher speed

### uses tshark to detect attacks such as bruteforce, scans and more

To run this script as a cronjob in the background, you can add the following line to your crontab file (crontab -e):


```
* * * * * /path/to/network_monitor.sh >/dev/null 2>&1 &
```
