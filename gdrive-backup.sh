#!/bin/sh
#
# Backup folder on google drive
#
archive_filename=/tmp/gdrive-backup-archive-$(date -u +%s).tar
encrypted_filename="$archive_filename".gpg

# Clean old backups function
# $1: Number of backups to keep
clean_backups () {
    done=false
    while [ "$done" = false ]
    do
        # Find the list of encrypted backups
        backups=$(gdrive list | grep gpg | cut -d ' ' -f15)

        count=$(printf "%s\n" "$backups" | wc -l)
        echo "$count backups left"

        if [ $count -gt $1 ]
        then
            # Find the dates of the listed backups
            dates=$(printf "%s\n" "$backups" | cut -d '.' -f1 | cut -d '-' -f4)

            # Find the oldest backup
            oldest=$(printf "%s\n" "$dates" | sort -g | head -n1)

            # Find the oldest backup's Google drive ID
            oldest_gdrive_id=$(gdrive list | grep $oldest | cut -d " " -f1)

            # Delete oldest backup
            gdrive delete $oldest_gdrive_id
        else
            done=true
        fi
    done
}

# Create archive
echo "Creating archive..."
cd $1
tar -cvf $archive_filename .

# Encrypting archive
echo "Encrypting archive..."
gpg --output $encrypted_filename --encrypt --recipient felix.leblanc1305@gmail.com $archive_filename

# Check if gdrive client is there
if [ ! -f /usr/bin/gdrive ]
then
    echo "You must install the google drive command line client"
    exit 1
fi

# Upload to google drive
echo "Uploading..."
gdrive upload $encrypted_filename

# Clean up old backups
echo "Deleting old backups"
clean_backups 2