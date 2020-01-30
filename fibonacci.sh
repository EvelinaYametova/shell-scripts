#!/bin/bash
if [[ -n ${1//[0-9]/}  && "$1" != "-h" && "$1" != "--help" || "$1" = "0" || "$1" = "" ]]; then
        echo "Incorrect arg! For help input --help or -h"
        exit
fi

if [[ "$1" = "-h" || "$1" = "--help" ]]; then
        echo "This script find nth Fibonacci number"
	echo "Usage: [thisScriptName] [n]"
        exit
fi

if [ "$1" = "1" ]; then
        echo 0
        exit
fi

first=0;
second=1;
result=1;
for (( i = 2; i < $1; i++ ))
do
        let result=$first+$second
        let first=$second
        let second=$result
done
echo $result

