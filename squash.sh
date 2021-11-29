#!/bin/sh

# FROM: https://stackoverflow.com/questions/598672/squash-the-first-two-commits-in-git
# TODO: Some how the squashed commits seem to be in history. Remove them to save time while filtering branches.

TOP_TREEISH=$1
BOTTOM_TREEISH=${2:-$(git rev-list --max-parents=0 HEAD)}
BRANCH=`git branch --show-current`

# Go back to the last commit that we want
# to form the initial commit (detach HEAD)
echo "Checking out $TOP_TREEISH"
git checkout $TOP_TREEISH >/dev/null 2>&1

COMMIT_MSG=`git show -s --format=%s`

# reset the branch pointer to the initial commit (= $BOTTOM_TREEISH),
# but leaving the index and working tree intact.
echo "Squashing commits till $BOTTOM_TREEISH"
git reset --soft $BOTTOM_TREEISH  >/dev/null 2>&1

# amend the initial tree using the tree from $TOP_TREEISH
git commit --amend -m "$COMMIT_MSG" >/dev/null 2>&1

# remember the new commit sha1
TARGET=`git rev-list HEAD --max-count=1`

# go back to the original branch (assume master for this example)
git checkout "$BRANCH" >/dev/null 2>&1

# Replay all the commits after $TOP_TREEISH onto the new initial commit
git rebase --onto $TARGET $TOP_TREEISH >/dev/null 2>&1
