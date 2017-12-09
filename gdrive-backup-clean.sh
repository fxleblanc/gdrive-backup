#!/bin/sh
#
# Clean old backups
#
done=false
while [ "$done" = false ]
do
    # Find the list of encrypted backups
    backups=$(gdrive list | grep gpg | cut -d ' ' -f15)

    count=$(printf "%s\n" "$backups" | wc -l)
    echo "$count backups left"

    if [ $count -gt 2 ]
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
