#!/bin/bash
# Sync dotfiles with them in the home directory

cd `dirname $0`/..

home_dir=$HOME # $HOME/tmp/nisehome
backup_dir=$HOME/tmp/backup_dir_dotfiles
if [ ! -e "${backup_dir}" ]; then
    echo "Create ${backup_dir}."
    mkdir ${backup_dir}
fi
dotties=(.??*)
#echo "${dotties[@]}"

for index in ${!dotties[@]}
do
    if [ "${dotties[${index}]}" = ".git" ]; then
        unset dotties[${index}]
    fi
done
echo "${dotties[@]}"
##-End-of-File-##
