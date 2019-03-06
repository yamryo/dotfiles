#!/bin/bash
#
# Setting up directories in home directory
#
# Time-stamp: <2015-08-09 23:13:33 (ryosuke)>

home_dir="/home/ryosuke"
default_dirs=("Documents" "Downloads" "Dropbox" "Nando" "tmp" "Workspace")

cd ${home_dir}

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

marr=($( { IFS=$'\n'; ls ${home_dir}; echo "${default_dirs[*]}"; } | sort | uniq -u ))
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
