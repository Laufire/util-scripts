#!/bin/bash

oldEmail=$1
newEmail=$2
newAuthorName=$3
flags=${@:4}

git filter-branch $flags --env-filter '
OLD_EMAIL="'"$oldEmail"'"
NEW_EMAIL="'"$newEmail"'"
NEW_AUTH_NAME="'"$newAuthorName"'"

if test "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL"
then
    GIT_COMMITTER_NAME="$NEW_AUTH_NAME"
    GIT_COMMITTER_EMAIL="$NEW_EMAIL"
fi
if test "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL"
then
    GIT_AUTHOR_NAME="$NEW_AUTH_NAME"
    GIT_AUTHOR_EMAIL="$NEW_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags