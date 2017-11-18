#!/bin/sh
#
# Backup folder on google drive
#
folder=$1
archive_filename=/tmp/gdrive-backup-archive-$(date -u +%s).tar
encrypted_filename="$archive_filename".gpg

# Create archive
echo "Creating archive..."
tar -cvf $archive_filename $1

# Encrypting archive
echo "Encrypting archive..."
gpg --output $encrypted_filename --encrypt --recipient felix.leblanc1305@gmail.com $archive_filename
