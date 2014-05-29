#!/bin/sh
cd ~/work/projects/apidocs 
/usr/bin/apiary preview --server > preview_server.out 2>&1 &
