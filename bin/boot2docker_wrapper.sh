#!/bin/sh
if [ "`boot2docker status`" != "running" ]; then
    boot2docker start
fi
$(boot2docker shellinit 2> /dev/null)
docker $*
