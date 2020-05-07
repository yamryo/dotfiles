#!/bin/bash
# Deploying dotfiles into the home directory

cd `dirname $0`/..

home_dir=$HOME # $HOME/tmp/nisehome
backup_dir=$HOME/tmp/backup_dir_dotfiles
if [ ! -e "${backup_dir}" ]; then
    echo "Create ${backup_dir}."
    mkdir ${backup_dir}
fi
#---
for dotty in .??*
do
    copy_flag=0
    if [ "${dotty}" = ".git" ]; then
        echo "skip '${dotty}'" > /dev/null 2>&1
    else
        target=${home_dir}/${dotty}
        if [ ! -e "${target}" ]; then
            copy_flag=1
        else
            read -n1 -p "${target} exists. Overwrite?(y/N): " yn
            if [[ ${yn} = [yY] ]]; then
                echo
                copy_flag=1
                # back up target files
                if [ -d ${dotty} ]; then
                    for f in $(ls -A -1 ${target})
                    do
                        if [ -e "./${dotty}/${f}" ]; then
                            echo "back up ${f} into ${backup_dir}/"
                            cp -R ${target}/${f} ${backup_dir}/
                        fi
                    done
                else
                    echo "back up ${f} into ${backup_dir}/"
                    cp ${target} ${backup_dir}/
                fi
            else
                echo abort > /dev/null 2>&1
                copy_flag=0
            fi
        fi
    fi
    if [ $copy_flag -eq 1 ]; then
        cp -Rv ${dotty} ${home_dir}
    fi
done

##-End-of-File-##
