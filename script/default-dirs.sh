#!/bin/bash
#
# Setting up directories in home directory
#

default_dirs=("Documents" "Downloads" "Dropbox" "Nando" "tmp" "Workspace")

cd ${HOME}

#--- create directories
for dir in "${default_dirs[@]}"
do
      if [ -e $dir ]; then
	  echo "'${dir}' exists"
	  :
      else
#	  echo "'${dir}' does not exist"
	  mkdir ${dir}
	  :
      fi
done

#--- move directories
od_dir="Nando/OrigDirs"
mkdir ${od_dir}

marr=($( { IFS=$'\n'; ls ${HOME}; echo "${default_dirs[*]}"; } | sort | uniq -u ))
#echo "${marr[*]}"
 for dir in "${marr[@]}"
 do
    if [ -e ${dir} ]; then
        mv ${dir} ${od_dir}/
        echo "${dir} --> ${od_dir}/${dir}"
        :
    else
        echo "'${dir}' is not a directory"
        :
    fi
 done

##-#-##-#-##-#-##
##-End-of-File-##
##-#-##-#-##-#-##
