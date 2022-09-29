#!/bin/env bash

( 
echo "PID|TTY|STAT|TIME|COMMAND";

for pid in `ls -1 /proc/ | egrep '^[0-9]+' | sort -n`; do
  if [ -d /proc/$pid ]; then
    stat=`</proc/$pid/stat`
        
        cmd=`echo "$stat" | awk -F" " '{print $2}'`
        state=`echo "$stat" | awk -F" " '{print $3}'`
        tty=`echo "$stat" | awk -F" " '{print $7}'`
        utime=`echo "$stat" | awk -F" " '{print $14}'`
        stime=`echo "$stat" | awk -F" " '{print $15}'`
        ttime=$((utime + stime))
        time=$((ttime / 100))

        echo "${pid}|${tty}|${state}|${time}|${cmd}"
    fi
done ) | column -t -s "|"

