#!/bin/bash

# Runs the given command in all the subdirs of the CWD.

for dir in ./*/;
  do
    cd "$dir"
    eval $@
    cd ..
done;
