#!/bin/bash

FECHA=$(date +%Y-%m-%d%H-%M)
DESTINO="/home/backupuser/respaldos"
DB="BDDSGLAB6"
USER="sgapp_backup"
PASS="BackupITIUTU!"


mkdir -p "$DESTINO"

mysqldump -u $USER -p$PASS $DB > "$DESTINO/$DB.sql"
tar -czf "$DESTINO/respaldo${DB}_$FECHA.tar.gz" -C "$DESTINO" "$DB.sql"
rm "$DESTINO/$DB.sql"



