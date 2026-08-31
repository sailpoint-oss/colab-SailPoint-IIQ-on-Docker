#!/bin/bash
set -euo pipefail

SQLCMD="/opt/mssql-tools18/bin/sqlcmd"
if [ ! -x "$SQLCMD" ]; then
    SQLCMD="/opt/mssql-tools/bin/sqlcmd"
fi

for _ in $(seq 1 60); do
    if "$SQLCMD" -C -S localhost -U sa -P Change@123 -Q "SELECT 1" >/dev/null 2>&1; then
        break
    fi
    sleep 2s
done

echo "********************" 
echo "START EXEC STARTUP.SH"
echo "********************" 
count=0
pathScripts="/tmp/scripts/"
for entry in $(find "$pathScripts" -maxdepth 1 -type f | sort -V); do
    "$SQLCMD" -C -S localhost -U sa -P Change@123 -i "$entry" -o "/tmp/execucao${count}.txt"
    count=$(($count+1))
done
rm -rf "${pathScripts:?}"*
echo "********************" 
echo "END EXEC  STARTUP.SH"
echo "********************" 
