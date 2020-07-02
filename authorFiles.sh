#!/bin/sh

# Stats the file-wise contribution of the given author in a git repo / dir.

author=$1

if [ -z $author ]; then

  echo "Usage: $ script [authorName without spaces]"
  exit 1
fi

git ls-files | while read f
do
  count=$(git blame "$f" | grep $author | wc -l)
  if [ $count -ne 0 ]; then
    echo $f $count
  fi
done | sort -n -k2
