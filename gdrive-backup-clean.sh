#!/bin/sh
#
# Clean old backups
#

# Find the list of encrypted backups
backups=$(gdrive list | grep gpg | cut -d ' ' -f15)

# Find the dates of the listed backups
dates=$(printf "%s\n" "$backups" | cut -d '.' -f1 | cut -d '-' -f4)

# Find the oldest backup
oldest=$(printf "%s\n" "$dates" | sort -g | head -n1)

# Find the oldest backup's Google drive ID
oldest_gdrive_id=$(gdrive list | grep $oldest | cut -d " " -f1)

# Delete oldest backup
gdrive delete $oldest_gdrive_id
