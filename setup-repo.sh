#!/bin/bash

if [ ! -d "trunk" ]
then
    git clone git://git.sv.gnu.org/emacs.git trunk
fi

if [ ! -d "emacs-jabber" ]
then
    git clone https://github.com/legoscia/emacs-jabber.git emacs-jabber
fi

