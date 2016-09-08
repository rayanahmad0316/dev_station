#!/usr/bin/env python
import itertools
import math


def divide(iterable, piece_count):
    seq = tuple(iterable)
    size = math.ceil(len(seq) / float(piece_count))
    groups = []
    group = []
    for item in seq:
        group.append(item)
        if len(group) == size:
            groups.append(group)
            group = []
    if group:
        groups.append(group)
    
    while len(groups) < piece_count:
        groups.append([])

    return groups


f = open('revisions')
revisions = [(index, line.strip()) for index, line in enumerate(f)]
f.close()

threshold_revision = None
while revisions:
    leftgroup, rightgroup = divide(revisions, 2)

    if rightgroup:
        print 'leftgroup: {}, rightgroup: {}'.format(len(leftgroup), len(rightgroup))
        print 'Test {!r}'.format(rightgroup[0])
        response = raw_input('Condition match? y/n: ')

        if response == 'y':
            threshold_revision = rightgroup[0]
            revisions = rightgroup
        elif len(leftgroup) == 1 and threshold_revision:
            break
        else:
            revisions = leftgroup
    else:
        threshold_revision = leftgroup[0]
        break

print 'Threshhold revision is {}'.format(threshold_revision)
