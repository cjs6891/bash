#!/bin/bash

today=`/bin/date +%F`
minus7=`/bin/date +%F -d '-7 day'`
minus14=`/bin/date +%F -d '-14 day'`
minus21=`/bin/date +%F -d '-21 day'`

WorkingDirectory="/root/System_Administration/WorkInProgress/"

cd $WorkingDirectory
array=(`ls -ltra *.sql | /bin/awk '{print $9}' | /bin/awk -F "." '{print $1}'`)

for i in ${array[@]}; do
if [[ $i < $minus7 ]]; then
rm -f $i.sql
fi
done
