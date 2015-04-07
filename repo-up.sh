#!/bin/bash
LC_ALL=C
LANG=C
export LANG LC_ALL
date=`date -u +%Y%m%d`
trunkdir=/home/fyue/emacs/trunk
builddir=/home/fyue/emacs/build-$date
cedetdir=/home/fyue/emacs/cedet
ecbdir=/home/fyue/emacs/ecb
orgmodedir=/home/fyue/emacs/org-mode

# emacs 
cd $trunkdir
rm ./.gitignore
git status -s | grep '^??' | sed 's/^??\s*//' | xargs rm
git status -s | grep '^??' | sed 's/^??\s*//' | xargs rm -r
git checkout -- .gitignore
git pull
git status

# # cedet 
# cd $cedetdir
# bzr ignored | awk '{print $1}' | xargs rm -rf
# bzr up
# bzr status
