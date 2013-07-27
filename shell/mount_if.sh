#!/bin/bash

function mount_if_not_exist() {
    argc=$#;
    target="$1";
    cmd="$2";

    if [ $argc -le 1 ]
    then
        echo "usage: ./test.sh \"target\" \"mount command\""
        echo e.g.: 
        echo "  "./mount_if.sh \"/mnt/hgfs\" \"mount -t vmhgfs .host:/ /mnt/hgfs\"
        exit 1
    fi

    result=`mount | grep $target`
    if [ -z "$result" ]; then
        echo $cmd
        echo $cmd > .cmd
        chmod +x .cmd
        ./.cmd
        rm .cmd
    fi
}

mount_if_not_exist "$@"

