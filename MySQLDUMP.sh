#!/bin/bash
##MySQLdump W/Remote Import

DATE=$(date +%Y%m%d)
RMDATE=$(date +%Y%m%d --date="-7days")
USERNAME=USERNAME
PASSWORD=PASSWORD
# MySQLDUMP Privileges: SELECT, LOCK TABLES, SHOW VIEW
REMOTE_HOST=192.168.X.X

RemoteDirectory="/opt/MySQLDUMPS"
OutputDirectory="/opt/MySQLDUMPS"

DATABASES=(
'database1'
'database2'
'database3'
)

COUNT=${#DATABASES[@]}

for ((i = 0; i < $COUNT; i++)); do
  mysqldump -u$USERNAME -p$PASSWORD --skip-lock-tables ${DATABASES[$i]} > $OutputDirectory/${DATABASES[$i]}-$DATE.sql
  tar -czf $OutputDirectory/${DATABASES[$i]}-$DATE.sql.tar.gz $OutputDirectory/${DATABASES[$i]}-$DATE.sql --remove-files &> /dev/null
  rm $OutputDirectory/${DATABASES[$i]}-$RMDATE.sql.tar.gz
done

rsync -avze ssh --delete-after $OutputDirectory/ root@$REMOTE_HOST:$RemoteDirectory/ &> /dev/null

for ((j = 0; j < $COUNT; j++)); do
  IMPORT="tar -xzOf $RemoteDirectory/${DATABASES[$j]}-$DATE.sql.tar.gz | mysql -u$USERNAME -p$PASSWORD ${DATABASES[$j]}"
  ssh root@$REMOTE_HOST "$IMPORT"
done
