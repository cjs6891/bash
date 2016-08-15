#! /bin/bash

# RFC-1918, 
# https://tools.ietf.org/html/rfc1918

ifconfig="/sbin/ifconfig"
grep="/bin/grep -E"
awk="/usr/bin/awk"

$ifconfig | $grep 'inet\ addr:' | $grep '(192\.168|10\.|172\.1[6789]\.|172\.2[0-9]\.|172\.3[01]\.)' | $awk '{print $2}' | $awk -F ':' '{print $2}'