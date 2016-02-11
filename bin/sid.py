#!/usr/bin/env python

import itertools
import sys


def group(iterable, size, fillvalue=None):
    args = [iter(iterable)] * size
    return itertools.zip_longest(*args, fillvalue=fillvalue)

sid = sys.argv[1]

hsid = hex(int(sid.lstrip('#')))[2:]
hsid = '0' + hsid if len(hsid) % 2 else hsid

small_chunks = tuple(''.join(item) for item in group(hsid, 2))
# big_chunks = (''.join(item) for item in group(small_chunks, 2))

sys.stdout.write('{}-{}\n'.format(
    '-'.join(small_chunks[:-2]), ''.join(small_chunks[-2:])))
