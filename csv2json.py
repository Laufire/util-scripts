#!/usr/bin/env python

r"""
Displays some rudimenatry stats of the fed input stream
"""
# Imports
import sys
import codecs
import locale
sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout)
import fileinput

# State
Lines = {}

# for line in fileinput.input():
#     line = line.strip()
#     Lines[line] = Lines.get(line, 0) + 1

# Buffer = []
# for k, v in Lines.iteritems():
#     Buffer.append('%s: %s' % (k, v))

# Buffer.sort()

# for line in Buffer:
#     print line

import csv  
import json
  
def unicode_csv_reader(utf8_data, dialect=csv.excel, **kwargs):
    csv_reader = csv.reader(utf8_data, dialect=dialect, **kwargs)
    for row in csv_reader:
        yield [unicode(cell, 'utf-8') for cell in row]

reader = csv.DictReader(fileinput.input())  
# Parse the CSV into JSON  
# out = json.dumps( [ row for row in reader ] )  
print [ row for row in reader ]
