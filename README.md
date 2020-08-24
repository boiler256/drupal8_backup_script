# Drupal8 Backup Script
Simple BASH script to automate full site backups, keeping your files and database safe, also storing current information about PHP environment
## Usage
```sh
./drupal8_backup.sh
```

## Operability confirmed
* Ubuntu, Debian, CentOS, Unix - like OS
## Requirements
* zip

## Tips/Optional 
Uncomment those lines to add additional features to the backup script
### Keep needed backups with Find command, by default backups storage locally are 15 days
```sh
find $ARCHIVE_DIR -type f -name "$PROJECT_NAME-*" -mtime +15 -delete
```
### Copy backup to a cloud storage (AWS S3)
```sh
aws s3 cp $FILE_NAME s3://your_backet/drupal/backup/
```
### Put Drupal8 site to maintenance mode
```sh
$DRUPAL_DIR"vendor/bin/drush" vset --always-set maintenance_mode 1
```
### Rebuld Drupal8 Cache
```sh
$DRUPAL_DIR"vendor/bin/drush" cr
```
## Restore commands
1. Unzip
2. Uplaod/replace mysql database
3. Adjust settings if changed

