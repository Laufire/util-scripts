#!/bin/bash

# Stats the current author-wise contribution of a git repo / dir.

# Config
pattern=$1

# Main
git ls-files -- $pattern | while read f
  do git blame -w -M -C -C --line-porcelain "$f" | grep -I '^author ' | sed 's/^author //g'
done | sort -f | uniq -ic | sort -n
