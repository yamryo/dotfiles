#!/bin/bash
#
# Putting dotfiles into home directory
#
# Time-stamp: <2016-02-25 15:00:06 (ryosuke)>

cd `dirname $0`/..
#echo $PWD

for dir1 in $(ls ./configurations)
do
    if [ "${dir1}" = "not-auto-copy.config" ]; then
	echo "skip '${dir1}'" > /dev/null 2>&1
    else
	for dotty in $(ls -A ./configurations/${dir1}/)
	do
	    if [ -e ~/${dotty} ]; then
		echo "${dotty} already exists"
	    else
		echo "copy '${dotty}' into the home directory"
		cp -R ./configurations/${dir1}/${dotty} ~
	    fi
	done
    fi
done

##-#-##-#-##-#-##
##-End-of-File-##
##-#-##-#-##-#-##
