#!/bin/sh
#
# Backup folder on google drive
#
folder=$1

# Create archive
echo "Creating archive..."
tar -cvf /tmp/gdrive-backup-archive-$(date -u +%s).tar $1
