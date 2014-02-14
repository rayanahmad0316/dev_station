#!/bin/sh
SSH_SPEC_TARGET=$1
PATH_LOCAL_ID=id_rsa.pub
PATH_ID_STORE=authorized_keys

cat ~/.ssh/$PATH_LOCAL_ID | ssh $SSH_SPEC_TARGET "mkdir -p -m 700 ~/.ssh && touch ~/.ssh/$PATH_ID_STORE && chmod 600 ~/.ssh/$PATH_ID_STORE && cat - >> ~/.ssh/$PATH_ID_STORE"
