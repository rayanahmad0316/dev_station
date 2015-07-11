#!/bin/sh
ssh -t wandrsmith '. $OPENSHIFT_REPO_DIR/bin/approot; bash'
