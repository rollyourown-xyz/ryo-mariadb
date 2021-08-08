#!/bin/sh

##
## Database backup script
##

# Variables
RETAIN_DAYS=5
DATE=$(date +"%Y-%m-%d")
BACKUP_PATH='/var/mdbbackup'

# Perform backup
mysqldump -u root --flush-logs --all-databases | gzip > $BACKUP_PATH/all_db_backup_$DATE.sql.gz

# Remove old backups
find $BACKUP_PATH -mtime +$RETAIN_DAYS -delete