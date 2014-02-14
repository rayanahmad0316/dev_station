#!/bin/sh
SSH_SPEC_TARGET=$1
PATH_SSH_DIR=~/.ssh
PATH_LOCAL_ID=$PATH_SSH_DIR/id_rsa.pub
PATH_ID_STORE=$PATH_SSH_DIR/authorized_keys

cat $PATH_LOCAL_ID | ssh $SSH_SPEC_TARGET "mkdir -p -m 700 $PATH_SSH_DIR && touch $PATH_ID_STORE && chmod 600 $PATH_ID_STORE && cat - >> $PATH_ID_STORE"
