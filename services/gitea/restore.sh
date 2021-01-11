#!/bin/bash

#To find the latest log to restore
#find /storage-pool/backups/gitea/ -mtime 0 -type f -name "gitea-dump-*.zip" | sort | tail -1

set -e

#Check if the user gave us the zip file they want to restore or not
if [[ $# -eq 0 ]]
then
        echo "You need to give us the ZIP file you want to restore"
        exit 1
fi

#System variables
TMP_DIR=/tmp
GITEA_ZIP=$1
GITEA_DUMP=$TMP_DIR/$(basename $GITEA_ZIP)

#User variables
GITEA_COMPOSE=/mnt/vmstorage/docker/gitea/docker-compose.yml
DB_HOST=[REDACTED]
GIT_VOLUME=/data/gitea/data/git
GITEA_VOLUME=/data/gitea/data/gitea
DB_NAME=[REDACTED]
DB_ROOT_USERNAME=[REDACTED]
DB_ROOT_PASSW=[REDACTED]
DB_GITEA_USERNAME=[REDACTED]
GITEA_USER_ID=1000

echo "Restoring: $(basename $GITEA_ZIP)"

/usr/local/bin/docker-compose -f $GITEA_COMPOSE down

echo "Cleaning Gitea Git folder"
rm -rf $GIT_VOLUME

echo "Unpacking $GITEA_ZIP to $TMP_DIR"
unzip -q -u $GITEA_ZIP -d $GITEA_DUMP -x log/* app.ini

mkdir -p $GITEA_VOLUME $GIT_VOLUME

echo "Copying config dump into $GITEA_VOLUME"
rsync -ah $GITEA_DUMP/data $GITEA_VOLUME/ --exclude gitea-*

echo "Moving Git repositories into $GIT_VOLUME"
rsync -ah $GITEA_DUMP/repos/* $GIT_VOLUME/repositories

echo "Applying permissions"
chown -R $GITEA_USER_ID:$GITEA_USER_ID $GIT_VOLUME $GITEA_VOLUME
chmod -R g+rw $GIT_VOLUME $GITEA_VOLUME

echo "Cleaning database"
mysql -u $DB_ROOT_USERNAME -p$DB_ROOT_PASSW -h $DB_HOST -e 'DROP DATABASE '"${DB_NAME}"';'

echo "Creating new database"
mysql -u $DB_ROOT_USERNAME -p$DB_ROOT_PASSW -h $DB_HOST -e 'CREATE DATABASE '"${DB_NAME}"';'
mysql -u $DB_ROOT_USERNAME -p$DB_ROOT_PASSW -h $DB_HOST -e 'GRANT ALL PRIVILEGES ON '"${DB_NAME}"'.* TO '"'${DB_GITEA_USERNAME}'"'@'"'%'"';'

echo "Restoring database"
cat $GITEA_DUMP/gitea-db.sql | mysql -u $DB_ROOT_USERNAME -p$DB_ROOT_PASSW -h $DB_HOST $DB_NAME

echo "Restoring complete. Starting Gitea"
/usr/local/bin/docker-compose -f $GITEA_COMPOSE up -d

echo "Cleaning up"
rm -rf $GITEA_DUMP

echo "Check the logs for any errors:"
echo "tail -F $GITEA_VOLUME/log/gitea.log"

echo "Done.
