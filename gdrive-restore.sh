#!/bin/sh
#
# Restore folder from google drive
#

# Check if gdrive client is there
if [ ! -f /usr/bin/gdrive ]
then
    echo "You must install the google drive command line client"
    exit 1
fi

# Get most recent gdrive file id
backups=$(gdrive list | grep gpg | cut -d ' ' -f15)
dates=$(printf "%s\n" "$backups" | cut -d '.' -f1 | cut -d '-' -f4)
newest=$(printf "%s\n" "$dates" | sort -g | tail -n1)
newest_gdrive_id=$(gdrive list | grep $newest | cut -d " " -f1)

# Download from google drive
echo "Downloading..."
gdrive download --path /tmp $newest_gdrive_id

# Decrypting archive
echo "Decrypting archive..."
encrypted_filename=$(gdrive list | grep $newest | cut -d " " -f15)
archive_filename=$(printf "%s\n" "$encrypted_filename" | cut -d '.' -f1-2)
gpg --output /tmp/$archive_filename --decrypt --recipient felix.leblanc1305@gmail.com /tmp/$encrypted_filename

# Creating the target directory
if [ ! -d $1 ]
then
    mkdir $1
fi

# Unpack the archive
cd $1
tar -xvf /tmp/$archive_filename