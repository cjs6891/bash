#!/bin/bash

google=`dig @ns1.google.com TXT o-o.myaddr.l.google.com +short | sed 's/"//g'`
#akamai=`dig @ns1-1.akamaitech.net ANY whoami.akamai.net +short`

newPublic=/tmp/newPublic.txt
oldPublic=/tmp/oldPublic.txt

echo $google > $newPublic

x=`sha256sum $newPublic | awk '{print $1}'`
y=`sha256sum $oldPublic | awk '{print $1}'`

if [ "$x" == "$y" ]; then
  echo "Hello, World." > /dev/null
else
  echo "Your Public IP Has Changed!"
  echo "Updating Dynamic DNS..."
fi

mv $newPublic $oldPublic
