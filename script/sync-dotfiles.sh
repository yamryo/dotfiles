#!/bin/bash
# Sync dotfiles with them in the home directory

cd `dirname $0`/..

home_dir=$HOME #/tmp/nisehome
backup_dir=$HOME/tmp/backup_dir_dotfiles
if [ ! -e "${backup_dir}" ]; then
    echo "Create ${backup_dir}."
    mkdir ${backup_dir}
fi
dotties=(.??*)

for index in ${!dotties[@]}
do
    if [ "${dotties[${index}]}" = ".git" ]; then
        unset dotties[${index}]
    fi
done

for dotty in ${dotties[@]}
do
    target=${home_dir}/${dotty}
    #echo
    #echo ">>>>> Start syncing >>>>>"
    #---
    if [ ! -e "${target}" ]; then
        read -n1 -p "${target} does not exist. Copy?(y/N): " yn
        if [[ ${yn} = [yY] ]]; then
            echo
            cp -Rv ${dotty} ${home_dir}
        fi
    else
        result=$(diff ${dotty} ${target}) &> /dev/null
        if [ $? -eq 0 ]; then
            #echo "${dotty} and ${target} are identical."
            echo &> /dev/null
        else
            echo "${dotty}"
            echo
            read -n1 -p "Diff files?(y/N): " yn
            if [[ ${yn} = [yY] ]]; then
                diff -u ${dotty} ${home_dir}/${dotty} | less -R
                echo
            fi
            read -n4 -p "Sync ${dotty}?(y/N): " yn
            if [[ ${yn} = [yY] ]]; then
                vimdiff ${dotty} ${home_dir}/${dotty}
            fi
        fi
    fi
    #---
    #echo "<<<<< Finish syncing <<<<<"
done
##-End-of-File-##
