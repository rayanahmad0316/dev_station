#!/bin/sh

if [ `uname` == 'Darwin' ]; then
    lsof -i | grep LISTEN
else
    netstat -tulpn
fi
