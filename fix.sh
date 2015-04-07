cd lisp; EMACSLOADPATH=/home/fyue/emacs/trunk/lisp LC_ALL=C ../src/emacs -batch --no-site-file --no-site-lisp --eval '(setq max-lisp-eval-depth 2200)' -f batch-byte-compile ../../trunk/lisp/cedet/srecode/srt-mode.el



# we need to exit with non-zero value so build.sh will re-run make to continue.
exit 1
