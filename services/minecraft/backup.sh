#!/bin/bash
ID="haro"
WORLD="world"
DATE=$(date +"%d-%m-%Y-%H-%M-%S")
BASE_FOLDER="/data/server/serverfiles" #NO TRAILING SLASH!

mkdir -p /tmp/${ID}

rclone mkdir crypt:/serverdata/${ID}/${DATE}

#Overworld
echo Zipping Overworld to /tmp/${ID}/${WORLD}.zip...
zip -r /tmp/${ID}/${WORLD}.zip ${BASE_FOLDER}/${WORLD}/*

rclone move /tmp/${ID}/${WORLD}.zip crypt:/serverdata/${ID}/${DATE}/

#Nether
echo Zipping Nether to /mnt/google_drive/serverdata/${ID}.zip...
zip -r /tmp/${ID}/${WORLD}_nether.zip ${BASE_FOLDER}/${WORLD}_nether/*

rclone move /tmp/${ID}/${WORLD}_nether.zip crypt:/serverdata/${ID}/${DATE}/

#End
echo Zipping End to /mnt/google_drive/serverdata/${ID}.zip...
zip -r /tmp/${ID}/${WORLD}_the_end.zip ${BASE_FOLDER}/${WORLD}_the_end/*

rclone move /tmp/${ID}/${WORLD}_the_end.zip crypt:/serverdata/${ID}/${DATE}/

rm -rf /tmp/${ID}
echo Done.
