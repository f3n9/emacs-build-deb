#!/bin/bash

LC_ALL=C
LANG=C
export LANG LC_ALL

date=`date -u +%Y%m%d`
trunkdir=/home/fyue/emacs/trunk
builddir=/home/fyue/emacs/build-$date
emacsjabber=/home/fyue/emacs/emacs-jabber
installdir=/home/fyue/emacs-latest


# emacs 
cd $trunkdir

# remove ignored files/dirs
rm ./.gitignore
git status -s | grep '^??' | sed 's/^??\s*//' | xargs rm
git status -s | grep '^??' | sed 's/^??\s*//' | xargs rm -r
git checkout -- .gitignore

git status
echo Waiting 10 seconds
sleep 10

./autogen.sh || exit 1

rm -rf $builddir
mkdir -p $builddir
cd $builddir

../trunk/configure --prefix=$installdir $1 --without-jpeg --without-png --without-tiff --without-gif --without-xaw3d --without-xpm || exit 2
make || ../fix.sh || make || exit 3
make all || exit 4
rm -rf $installdir
make install || exit 5

# copy required binaries/libraries to $installdir/{bin,lib} 
mkdir -p $installdir/bin 2>/dev/null
cp /usr/bin/w3m $installdir/bin/
mkdir -p $installdir/lib 2>/dev/null
cp -L `ldd $installdir/bin/emacs | grep libXaw | awk '{print $3}'` $installdir/lib/
cp -L `ldd $installdir/bin/emacs | grep libXmu | awk '{print $3}'` $installdir/lib/
cp -L `ldd $installdir/bin/emacs | grep libXpm | awk '{print $3}'` $installdir/lib/
cp -L `ldd $installdir/bin/emacs | grep libXt | awk '{print $3}'` $installdir/lib/
cp -L `ldd $installdir/bin/emacs | grep libSM | awk '{print $3}'` $installdir/lib/
cp -L `ldd $installdir/bin/emacs | grep libICE | awk '{print $3}'` $installdir/lib/
#cp -L `ldd $installdir/bin/emacs | grep libxml2 | awk '{print $3}'` $installdir/lib/
#cp -L `ldd $installdir/bin/emacs | grep libgnutls | awk '{print $3}'` $installdir/lib/
cp -L `ldd $installdir/bin/w3m | grep libgc.so | awk '{print $3}'` $installdir/lib/
# for gdbm used by emacs-evernote-mode-mod
cp -L /usr/lib/libgdbm.so.3 $installdir/lib/libgdbm.so

emacsvers=`cd $installdir/share/emacs; ls -d [0-9]*| head -n 1`

# emacs-jabber
# cd $emacsjabber
# git pull
# autoreconf -i -f  || exit 7
# ./configure EMACS=/home/fyue/emacs-latest/bin/emacs --prefix=/home/fyue/emacs-latest  || exit 8
# make  || exit 9 
# make install || exit 10

cd /home/fyue
rm -f emacs-latest-$date.tar.bz2
tar cjf emacs-latest-$date.tar.bz2 emacs-latest
