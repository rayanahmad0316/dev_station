#!/usr/bin/env python
import os

for path, dirs, files in os.walk("/Users/warren/Library"):
    for fname in files:
        fpath = os.path.join(path, fname)
        try:
            with open(fpath) as flo:
                for line in flo:
                    if "superfish" in line:
                        print fpath
                        break
        except Exception as e:
            print str(e)
            continue
