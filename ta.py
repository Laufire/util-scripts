#!/usr/bin/env python

r"""
Displays some rudimenatry stats of the fed input stream
"""
# Imports
import fileinput

# State
Lines = {}

for line in fileinput.input():
    line = line.strip()
    Lines[line] = Lines.get(line, 0) + 1

Buffer = []
for k, v in Lines.iteritems():
    Buffer.append('%s: %s' % (k, v))

Buffer.sort()

for line in Buffer:
    print line
