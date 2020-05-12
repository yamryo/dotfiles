#!/bin/bash
# Sync dotfiles with them in the home directory

cd `dirname $0`/..

home_dir=$HOME #/tmp/nisehome #
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

##--- Define function ------------
sync_files () {
    local item=${1}
    local target=${home_dir}/${item}
    #---
    result=$(diff -q ${item} ${target} &> /dev/null)
    case $? in
        0)
            #echo "${item} and ${target} are identical."
            return 0
            ;;
        2)
            read -n1 -p "${target}: Not exist. Copy?(y/N): " yn
            echo
            if [[ ${yn} = [yY] ]]; then
                test -d ${item} && opt="-Rv" || opt="--parents -v"
                cp ${opt} ${item} ${home_dir}
                echo
            fi;;
        *)
            if [ -d ${item} ]; then
                echo "${item} is a directory"
                #echo
                for file in $(find ${item} -type f)
                do
                    sync_files ${file}
                done
            else
                #TODO: code to overwrite the file.
                echo ${item}
                read -n1 -p "Diff files?(y/N): " yn
                echo
                if [[ ${yn} = [yY] ]]; then
                    diff -u ${item} ${target} | less -R
                fi
                read -n1 -p "Merge files with vimdiff?(y/N): " yn
                echo
                if [[ ${yn} = [yY] ]]; then
                    vimdiff ${item} ${target}
                fi
            fi;;
    esac
}
##--------------------------------

for dotty in ${dotties[@]}
do
    sync_files ${dotty}
done

##-End-of-File-##
