# Backup script for select MariaDB databases

Backups are written to a Google Drive mount.

### Cronjob
Backup every hour
```
0 * * * * /scripts/backup.sh >> /scripts/backup.log
```

