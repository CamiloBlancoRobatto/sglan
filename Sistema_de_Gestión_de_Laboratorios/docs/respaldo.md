# 🛡️ Script de respaldo de base de datos MySQL/MariaDB

Este script realiza un respaldo automático de la base de datos `BDDSGLAB6`, lo comprime en formato `.tar.gz` y lo guarda en una carpeta específica. Además, se configura para ejecutarse automáticamente todos los lunes a las 12:00 del mediodía mediante `crontab`.

---

## 📜 Script utilizado

```bash
#!/bin/bash

# CONFIGURACIÓN BÁSICA
FECHA=$(date +%Y-%m-%d%H-%M)
DESTINO="/home/Los Cosmicos/Respaldos"
DB="BDDSGLAB6"
USER="AdminBD"
PASS="Admin1234"

# Crear carpeta si no existe
mkdir -p "$DESTINO"

# Hacer backup y comprimirlo directamente con tar
mysqldump -u $USER -p$PASS $DB > "$DESTINO/$DB.sql"
tar -czf "$DESTINO/respaldo${DB}_$FECHA.tar.gz" -C "$DESTINO" "$DB.sql"
rm "$DESTINO/$DB.sql"
