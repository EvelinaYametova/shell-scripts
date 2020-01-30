#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        echo "This script creat gif-animation, which consist in turning the jpg-image clockwis"
        echo "Rotation angle, animation time, the name of the original jpg-image and the name file with the result of the script takes as parametrs"
	echo "Becuase the turning is clockwis the angle should be more equal zero or zero"
	echo "For run input ./imagemagic.sh [angle] [time] [name jpg-image] [name gif-animation]"
	echo "Also you can to run this script without fourth argument"
        exit 0
fi

if [[ "$1" == "" || "$2" == "" || "$3" == "" || "$1" -lt "0" || "$2" -lt "0" || ! -f "$3" || ! $(file -b "$3") =~ JPEG ]]; then
        echo "Incorrect arg! For help input --help or -h"
        exit 0
fi

let corner=$1%360
tm=$2
nameJpg=$3
if [ "$4" == "" ]; then
        nameGif="${nameJpg%.*}.gif"
else
        nameGif=$4
fi

if [ "$nameGif" == "$nameJpg" ]; then
	nameGif="${nameJpg}.gif"
fi

if [ -f "$nameGif" ]; then
	while true; do
		nameGif="${nameGif%.*}${RANDOM}.gif"
		if [ ! -f "$nameGif" ]; then
			break
		fi
	done
fi

nod=$corner
b=360
while [[ $nod != $b ]]; do
    if [[ $nod -gt $b ]]; then
            ((nod-=$b))
    else
            ((b-=$nod))
    fi
done

let nok=$corner*360/$nod
last=$(($nok-$corner))
seq -w 0 $corner $last | xargs -I DEGREE convert $nameJpg -alpha set \( +clone -background none -rotate DEGREE \) \
-gravity center -compose src -composite ${nameJpg%.*}-DEGREE.jpg
convert -delay $tm -loop 0 ${nameJpg%.*}-*.jpg $nameGif
rm ${nameJpg%.*}-*.jpg
