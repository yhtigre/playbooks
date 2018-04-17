#!/bin/sh
##
## Copyright (c) 2017 TATEIWA-SHACHU, LLC. All rights reserved.
##
##  Zabbix LLD script. Monitor the status of Phusion Passenger.
##

PASSENGER_STATUS_CMD=`sudo /usr/local/rbenv/shims/passenger-status`
PASSENGER_MEMORY_STATS_CMD=`sudo /usr/local/rbenv/shims/passenger-memory-stats`

##
## Max pool size.
##
max_pool_size() {
  echo "$PASSENGER_STATUS_CMD" | awk -F: '/Max pool size/ {print $2}'
  exit 0
}

##
## Requests in top-level queue.
##
top_level_queue() {
  echo "$PASSENGER_STATUS_CMD" | awk -F: '/Requests in top-level queue/ {print $2}'
  exit 0
}

##
## Requests in queue.
##
queue() {
  expr `echo "$PASSENGER_STATUS_CMD" | awk -F: '/Requests in queue/ {print $2}'` + 0
  exit 0
}

##
## httpd processes.
##
httpd_proc_num() {
  expr `echo "$PASSENGER_MEMORY_STATS_CMD" | awk -F: '/Processes/ {print $2}' | sed -n -e '1p'` + 0
  exit 0
}

##
## httpd total RSS.
##
httpd_total_rss() {
  echo "$PASSENGER_MEMORY_STATS_CMD" | awk -F: '/Total private dirty RSS/ {print $2}' | sed -n -e 's/MB//' -e '1p'
  exit 0
}

##
## Passenger processes.
##
passenger_proc_num() {
  expr `echo "$PASSENGER_MEMORY_STATS_CMD" | awk -F: '/Processes/ {print $2}' | sed -n -e '3p'` + 0
  exit 0
}

##
## Passenger total RSS.
##
passenger_total_rss() {
  echo "$PASSENGER_MEMORY_STATS_CMD" | awk -F: '/Total private dirty RSS/ {print $2}' | sed -n -e 's/MB//' -e '3p'
  exit 0
}


type -t "$1" >/dev/null 2>&1
if [ $? -eq 0 ]; then
  "$1"
fi

exit 1

## -------------------------------------------------------------------------------
## Do not execute afterward.
## -------------------------------------------------------------------------------

##
## Option parse.
##
OPTIONS=`getopt -o ":"   \
  -l max-pool-size       \
  -l top-level-queue     \
  -l queue               \
  -l httpd-proc-num      \
  -l httpd-total-rss     \
  -l passenger-proc-num  \
  -l passenger-total-rss \
 -- "$@"`

if [ $? -ne 0 ]; then
  exit 0
fi

eval set -- "$OPTIONS"
until [ "$1" == "--" ]; do
  case "$1" in
  --max-pool-size)
      max_pool_size
      ;;
  --top-level-queue)
      top_level_queue
      ;;
  --queue)
      queue
      ;;
  --httpd-proc-num)
      httpd_proc_num
      ;;
  --httpd-total-rss)
      httpd_total_rss
      ;;
  --passenger-proc-num)
      passenger_proc_num
      ;;
  --passenger-total-rss)
      passenger_total_rss
      ;;
  esac
  shift
done
exit 1
