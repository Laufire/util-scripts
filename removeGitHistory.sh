#!/bin/bash

deletePattern=$1

git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch $deletePattern" HEAD