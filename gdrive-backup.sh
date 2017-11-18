#!/bin/sh
#
# Backup folder on google drive
#
folder=$1
archive_filename=/tmp/gdrive-backup-archive-$(date -u +%s).tar

# Create archive
echo "Creating archive..."
tar -cvf $archive_filename $1
