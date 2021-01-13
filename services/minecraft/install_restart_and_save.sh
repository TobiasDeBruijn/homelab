#!/bin/bash

mkdir /home/mcserver
mkdir /data/scripts
cd /data/scripts
wget -q https://raw.githubusercontent.com/TheDutchMC/homelab/main/services/minecraft/restart.sh
wget -q https://raw.githubusercontent.com/TheDutchMC/homelab/main/services/minecraft/restart_15.sh
wget -q https://raw.githubusercontent.com/TheDutchMC/homelab/main/services/minecraft/restart_5.sh
wget -q https://raw.githubusercontent.com/TheDutchMC/homelab/main/services/minecraft/restart_1.sh
wget -q https://raw.githubusercontent.com/TheDutchMC/homelab/main/services/minecraft/save.sh 

chown -R mcserver:mcserver /data/scripts/
chmod u+rwx -R /data/scripts/

(crontab -l 2>/dev/null; echo "45 5,11,17,23 * * * /data/scripts/restart_15.sh > /data/scripts/cronlog/restart_warning_15.log") | crontab -u mcserver -
(crontab -l 2>/dev/null; echo "55 5,11,17,23 * * * /data/scripts/restart_5.sh > /data/scripts/cronlog/restart_warning_5.log") | crontab -u mcserver -
(crontab -l 2>/dev/null; echo "59 5,11,17,23 * * * /data/scripts/restart_1.sh > /data/scripts/cronlog/restart_warning_1.log") | crontab -u mcserver -
(crontab -l 2>/dev/null; echo "0 0,6,12,18 * * * /data/scripts/restart.sh > /data/scripts/cronlog/restart.log") | crontab -u mcserver -
(crontab -l 2>/dev/null; echo "*/20 * * * * /data/scripts/save.sh > /data/scripts/cronlog/save.log") | crontab -u mcserver -

echo "Done."
