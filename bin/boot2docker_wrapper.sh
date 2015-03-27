#!/bin/sh
if [ "`boot2docker status`" != "running" ]; then
    boot2docker start 2> /dev/null | grep --line-buffered -v 'connect' | grep -v 'export' 
fi
$(boot2docker shellinit 2> /dev/null)
docker $*
