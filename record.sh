#!/bin/bash
source print.sh
if [ 1 -ne $# ]
then
	#echo Usage: $0 resolution, such as \"$0 1\" 
	print_usage
	exit -1
fi
RESOLUTION=$1

if [[ $RESOLUTION  -eq 1 ]]
then
	FILENAME=FHD_1920x1080_60_8_`date +%Y%m%d%H%M%S`.yuv
	echo $FILENAME
	v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=1920,height=1080,pixelformat='UYVY' --stream-mmap=4 --stream-skip=3 --stream-count=500 --stream-to=$FILENAME --stream-poll
	echo "recorded to $FILENAME"
else
	if [[ $RESOLUTION -eq 2 ]]
	then
		FILENAME=FHD_1920x1080_60_10_`date +%Y%m%d%H%M%S`.yuv
		echo $FILENAME
		v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=1920,height=1080,pixelformat='UYVY' --stream-mmap=4 --stream-skip=3 --stream-count=20 --stream-to=$FILENAME --stream-poll
		echo "recorded to $FILENAME"
	else
		if [[ $RESOLUTION -eq 3 ]]
		then
			FILENAME=UHD_3840x2160_30_8_`date +%Y%m%d%H%M%S`.yuv
			echo $FILENAME
			v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=3840,height=2160,pixelformat='UYVY' --stream-mmap=4 --stream-skip=3 --stream-count=20 --stream-to=$FILENAME --stream-poll
			echo "recorded to $FILENAME"
		else
			if [[ $RESOLUTION -eq 4 ]]
			then
				FILENAME=UHD_3840x2160_30_10_`date +%Y%m%d%H%M%S`.yuv
				echo $FILENAME
				v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=3840,height=2160,pixelformat='UYVY' --stream-mmap=4 --stream-skip=3 --stream-count=20 --stream-to=$FILENAME --stream-poll
				echo "recorded to $FILENAME"
			else
				echo "only 1,2,3,4 supported"
			fi
		fi
	fi
fi
