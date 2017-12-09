install:
	cp gdrive-backup.sh /usr/bin/gdrive-backup
	cp gdrive-restore.sh /usr/bin/gdrive-restore

uninstall:
	rm /usr/bin/gdrive-backup
	rm /usr/bin/gdrive-restore