#!/bin/bash

# Variables
today=`/bin/date +%F`
fileExtension=".sql"
/bin/echo "Number of Previous Days?"
read -e X
minusX=`/bin/date +%F -d "-$X day"`
WorkingDirectory="/root/System_Administration/WorkInProgress/2017.09.03/"

# Script
cd $WorkingDirectory

if [[ -z "$X" ]]; then
  X=0
fi

while [ $X -ge 0 ]; do
minusX=`/bin/date +%F -d "-$X day"`
#/bin/echo $minusX$fileExtension
/bin/touch $minusX$fileExtension
X=$[$X-1]
done
