# Minecraft scripts

## Install
Install LinuxGSM and the latest Spigot:
```bash
wget https://raw.githubusercontent.com/TheDutchMC/homelab/main/services/minecraft/install_linuxgsm.sh && chmod +x install_linuxgsm.sh && sudo ./install_linuxgsm.sh
```
Install automatic restart and saving:
```
wget https://raw.githubusercontent.com/TheDutchMC/homelab/main/services/minecraft/install_restart_and_save.sh && chmod +x install_restart_and_save.sh && sudo ./install_restart_and_save.sh
```

## Cronjobs:
``root``:  
Backup every hour, on HOUR:30
```
30 0 * * * /data/scripts/backup.sh >> /data/scripts/cronlog/backup.log
```
``mcserver``:  
Restart warnings before every restart, which happens every 6 hours. Save every 20 minutes.
```
45 5,11,17,23 * * * /data/scripts/restart_15.sh > /data/scripts/cronlog/restart_warning_15.log
55 5,11,17,23 * * * /data/scripts/restart_5.sh > /data/scripts/cronlog/restart_warning_5.log
59 5,11,17,23 * * * /data/scripts/restart_1.sh > /data/scripts/cronlog/restart_warning_1.log
0 0,6,12,18 * * * /data/scripts/restart.sh > /data/scripts/cronlog/restart.log
*/20 * * * * /data/scripts/save.sh > /data/scripts/cronlog/save.log
```
