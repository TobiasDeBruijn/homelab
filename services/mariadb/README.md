# Backup script for select MariaDB databases

### Cronjob
Backup every hour
```
0 * * * * /scripts/backup.sh >> /scripts/backup.log
```

