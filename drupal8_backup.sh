#!/bin/bash

## Drupal 8 backup script
## Copyright (C) 2020 Alexander Sopkov
## Origin https://cmsintegrationguide.com

############
# Settings #
############

## Replace with your data
## Init variables

## Project name
PROJECT_NAME="drupal_site"

## MYSQL database settings
DB_NAME="drupal"
DB_USER="newuser"
DB_PASS="password"
DB_HOST="localhost"

## Drupal root directory
DRUPAL_DIR="/home/www/drupal8/"

## Directory to store drupal archives
ARCHIVE_DIR="/home/www/arch/"

##########
# Backup #
##########

## Prepare 
DATE=$(date +%Y%m%d-%H%M)
FILE_NAME=$ARCHIVE_DIR$PROJECT_NAME"-"$DATE".zip"
SQL_DUMP=$ARCHIVE_DIR$PROJECT_NAME"-"$DATE".sql"
PHP_SETTINGS_DUMP=$ARCHIVE_DIR"settings-php-"$DATE".txt"

## Run Drush
## Uncomment to Drupal8 site in maintenance mode 
# $DRUPAL_DIR"vendor/bin/drush" vset --always-set maintenance_mode 1

## Uncomment to Rebuld Cache before the backup 
# $DRUPAL_DIR"vendor/bin/drush" cr

## Archive files
## Exclude Git
zip -rDq $FILE_NAME $DRUPAL_DIR --exclude '*.git*'

## Backup mysql
mysqldump --user=$DB_USER --password=$DB_PASS --add-drop-table --host=$DB_HOST $DB_NAME > $SQL_DUMP

## Include SQL into archive
zip -uD $FILE_NAME $SQL_DUMP

## Delete used TEMP sql file
rm $SQL_DUMP

## Dump php settings
php -i > $PHP_SETTINGS_DUMP
zip -uD $FILE_NAME $PHP_SETTINGS_DUMP
rm $PHP_SETTINGS_DUMP

## Disable Drupal8 maintenance mode.
# $DRUPAL_DIR"vendor/bin/drush" vset --always-set maintenance_mode 0

## Optional
## Cloud backup
## Copy to S3 storage
# aws s3 cp $FILE_NAME s3://your_backet/drupal/backup/

## Optional
## Cleaning up old archives.
## Remove old backups >15 days
# find $ARCHIVE_DIR -type f -name "$PROJECT_NAME-*" -mtime +15 -delete

## Exit
echo "Backup created"