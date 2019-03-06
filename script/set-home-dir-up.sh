#!/bin/bash
#
# Setting up directories in home directory
#
# Time-stamp: <2016-02-25 15:08:04 (ryosuke)>

cd `dirname $0`/..

echo "---- Set default directories ----"
script/default-dirs.sh

echo "---- Copy dot files into the home directory ----"
script/arrange-dotfiles.sh

##-#-##-#-##-#-##
##-End-of-File-##
##-#-##-#-##-#-##
