#! /bin/bash
# Public IP Address

dig="/usr/bin/dig"
awk="/usr/bin/awk"

$dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | $awk -F'"' '{ print $2}'