#!/bin/sh
BACKUP_DIR=$1
if [ -d "${BACKUP_DIR}" ]; then
    /usr/bin/tar zcf ${BACKUP_DIR}/${USER}_osx_preferences.tgz -C ~/Library Preferences
else
    echo "Backup directory required."
    exit 1
fi
