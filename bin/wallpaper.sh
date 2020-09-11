#!/bin/bash

LOCKFILE="$HOME/.wallpaper.lock"
INTERVAL_MIN=15
trap 'echo "removing lock file"; rm -f "$LOCKFILE"' EXIT INT QUIT TERM HUP


if [ ! -f "$LOCKFILE" ]; then
        echo 1 > "$LOCKFILE"
else
       echo "Wallpaper manager already running" >&2
       exit 2
fi

count=0
while 
        if [ $(( count%${INTERVAL_MIN} )) -eq 0 ]; then
                [ -n $DISPLAY ] && feh --bg-center --randomize ~/.backgrounds/*;
        else
                [ -n $DISPLAY ]
        fi;
do 
        sleep 60;
        count=$(( count+1 )) 
done 
