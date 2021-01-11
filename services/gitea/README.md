# Gitea Backup & Backup Restore scripts
Require `root` privileges

### Cronjobs
Backup is done every 6 hours, restore is done at midnight, 5 minutes past the backup
```
0 0,6,12,18 * * * /data/gitea/scripts/backup.sh >> /data/gitea/scripts/backup.log 2>&1
5 0 * * * /data/gitea/scripts/restore.sh $(find /mnt/vmstorage/backups/gitea/ -mtime 0 -type f -name "gitea-dump-*.zip" | sort | tail -1) >> /data/gitea/scripts/restore.log 2>&1
```
