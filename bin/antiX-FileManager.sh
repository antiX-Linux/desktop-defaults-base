#!/bin/bash

DESKTOP_CODE=$(cat $HOME/.desktop-session/desktop-code$DISPLAY);
SESSION_FILE="$HOME/.desktop-session/session.conf";
case $DESKTOP_CODE in
    rox-*)
        rox-filer &
        ;;
    space-*)
        spacefm &
        ;;
    *)
        if [ -w "$SESSION_FILE" ] && grep -q "^Default-FM=" "$SESSION_FILE" ; then 
            FM=`cat $SESSION_FILE |grep "^Default-FM=" |cut -d "=" -f2` &&
            exec "$FM" &
        else
            FM="rox-filer" &&
            touch $SESSION_FILE &&
            echo "#This is where the menu, toolbar, and control center file manager should be set" > $SESSION_FILE &&
            echo "Default-FM=$FM" >> $SESSION_FILE &&
            exec "$FM" &
        fi
        ;;
esac