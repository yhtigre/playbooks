#!/bin/sh
##
## Copyright (c) 2017 TATEIWA-SHACHU, LLC. All rights reserved.
##
##  Zabbix LLD script. Automatically detect disk devices.
##

echo "{"
echo "\"data\": ["

while read -r line; do
  echo "{"

  echo "\"{#FSNAME}\": \"$(echo $line | awk '{print $2}')\","
  echo "\"{#FSTYPE}\": \"$(echo $line | awk '{print $3}')\","
  echo "\"{#FSDEV}\": \"$(echo $line | awk '{print $1}')\""

  echo "},"
done < /etc/mtab | sed -e '$d'

echo "}"
echo "]"
echo "}"
