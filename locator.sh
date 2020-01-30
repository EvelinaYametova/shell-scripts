#!/bin/bash

if [ "$1" == "" ]; then
        echo "Incorrect argument! To get help you need to run with --help or -h"
        exit 0
fi

if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        echo "This script allow know the command is internal or not"
	echo "If not then script output the path to the executable file"
        echo "For run input ./locator.sh [command]"
        exit 0
fi

IFS=:

help $1 2>/dev/null | egrep "^$1:"&>/dev/null

if [ "$?" == "0" ]; then
        echo "Internal command"
        exit 0
fi

for path in $PATH; do
        if [[ -x $path/${1##*/} && ! -d $path/${1##*/} ]]; then
                echo "$path/${1##*/}"
                exit 0
        fi
done

echo "Command no found"