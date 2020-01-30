#!/bin/bash

if [[ "$1" = "-h" || "$1" = "--help" ]]; then
        echo "This script output clear PATH (all directories which consist executable file(s))"
	echo "For run input ./clearpath.sh"
	echo "Also you can pass directories as argument. The colon acts as a separator. For example ./clearpath.sh /bin:/usr/games:/usr/bin"
	exit 0
fi

if [ -z "$1" ]; then
        dirs=$PATH
else
        dirs=$1
fi

IFS=:
flag=0
while true; do
        tmpFile="${RANDOM}.txt"
        if [ ! -f "$tmpFile" ]; then
        	 break
        fi
done

for dir in $dirs; do
        if [[ ! -d "$dir" ]]; then
		continue
        fi
        for file in "$dir"/*; do
                if [[ -f "$file" && -x "$file" ]]; then
			echo $dir >> $tmpFile
			flag=1
                        break
                fi
        done
done

if [ $flag = 0 ]; then
	echo "All directories are clear or are not exist"
else
	head -n -1 $tmpFile | tr -s "\n" ":"
	tail -n 1 $tmpFile
fi
rm $tmpFile 2> /dev/null
