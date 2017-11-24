#!/bin/sh
#
# Backup folder on google drive
#
archive_filename=/tmp/gdrive-backup-archive-$(date -u +%s).tar
encrypted_filename="$archive_filename".gpg

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
