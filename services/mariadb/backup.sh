#!/bin/bash
NOW=$(date +"%d-%m-%Y_%T")

PASSWORD=[REDACTED]
USERNAME=[REDACTED]
HOST=localhost
PORT=3306

echo "Starting backup: ${NOW}"

OUTPUT_PATH=/mnt/gdrive/mariadb

mysqldump --user=$USERNAME --password=$PASSWORD --host=$HOST --port=$PORT --verbose --lock-tables espocrm > $OUTPUT_PATH/espocrm/espocrm-$NOW.sql
mysqldump --user=$USERNAME --password=$PASSWORD --host=$HOST --port=$PORT --verbose --lock-tables thedutchmc_wiki > $OUTPUT_PATH/thedutchmc_wiki/thedutchmc_wiki-$NOW.sql
mysqldump --user=$USERNAME --password=$PASSWORD --host=$HOST --port=$PORT --verbose --lock-tables paytracker > $OUTPUT_PATH/paytracker/paytracker-$NOW.sql

echo "Done."
