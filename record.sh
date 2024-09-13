#!/bin/bash
source print.sh
if [ 1 -ne $# ]
then
	#echo Usage: $0 resolution, such as \"$0 1\" 
	print_usage
	exit -1
fi
RESOLUTION=$1
CNT=20

case $RESOLUTION in
1)
	FILENAME=FHD_1920x1080_60_packed_UYVY8_`date +%Y%m%d%H%M%S`.yuv
	echo $FILENAME
	v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=1920,height=1080,pixelformat='UYVY' --stream-mmap=4 --stream-skip=3 --stream-count=$CNT --stream-to=$FILENAME --stream-poll
;;
2)
	FILENAME=FHD_1920x1080_60_10_`date +%Y%m%d%H%M%S`.yuv
	echo $FILENAME
	v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=1920,height=1080,pixelformat='UYVY' --stream-mmap=4 --stream-skip=3 --stream-count=$CNT --stream-to=$FILENAME --stream-poll
;;
3)
	FILENAME=UHD_3840x2160_30_8_`date +%Y%m%d%H%M%S`.yuv
	echo $FILENAME
	v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=3840,height=2160,pixelformat='UYVY' --stream-mmap=4 --stream-skip=3 --stream-count=$CNT --stream-to=$FILENAME --stream-poll
;;
4)
	FILENAME=UHD_3840x2160_30_10_`date +%Y%m%d%H%M%S`.yuv
	echo $FILENAME
	v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=3840,height=2160,pixelformat='UYVY' --stream-mmap=4 --stream-skip=3 --stream-count=$CNT --stream-to=$FILENAME --stream-poll
;;
5)
	FILENAME=RGB_FHD_1920x1080_`date +%Y%m%d%H%M%S`.rgb
	echo $FILENAME
	v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=1920,height=1080,pixelformat='RGB3' --stream-mmap=4 --stream-skip=3 --stream-count=$CNT --stream-to=$FILENAME --stream-poll
;;
6)
	FILENAME=RGB_UHD_3840x2160_`date +%Y%m%d%H%M%S`.rgb
	echo $FILENAME
	v4l2-ctl --verbose -d /dev/video0 --set-fmt-video=width=3840,height=2160,pixelformat='RGB3' --stream-mmap=4 --stream-skip=3 --stream-count=$CNT --stream-to=$FILENAME --stream-poll
;;
*)
	print_usage
	exit 1
;;
esac
if [ $? -eq 0 ]
then 
	#echo "recorded to $FILENAME"
	echo -e "\e[1;40;31mrecorded to $FILENAME\e[m"
	ls -l $FILENAME
	exit 0
else
	
	echo -e "\e[1;40;31mFailed to record to $FILENAME\e[m"
	exit 1
fi
