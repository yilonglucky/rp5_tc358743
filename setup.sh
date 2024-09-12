#!/bin/bash
source print.sh
#######################################################################################################
#echo $#
if [ 1 -ne $# ]
then
	echo -e "\e[1;40;31mParameter need! Please refer to the usage below:\e[m"
	print_usage
	exit -1
fi
#######################################################################################################
RESOLUTION=$1
#MEDIA=$1
#echo MEDIA=$MEDIA
#MEDIANO=$1
#
MEDIANO=`v4l2-ctl --list-devices | grep -A 9 csi | grep /dev/media |sed 's/.*media//'`
#echo MEDIANO=$MEDIANO
#echo MEDIANODE=/dev/media$MEDIANO

MEDIANODE="/dev/media$MEDIANO"
#echo MEDIANODE=$MEDIANODE

######################################################################################################
#media-ctl -d $MEDIANODE -p

media-ctl -d $MEDIANODE -r
	if [ $? -ne 0 ]
	then
		exit 1
	fi
media-ctl -d $MEDIANODE -l ''\''csi2'\'':4 -> '\''rp1-cfe-csi2_ch0'\'':0 [1]'
	if [ $? -ne 0 ]
	then
		exit 1
	fi

case $RESOLUTION in
1)
	echo 1 > /sys/module/tc358743/parameters/resolution
	if [ $? -ne 0 ]
	then
		exit 1
	fi
	media-ctl -d $MEDIANODE -V ''\''tc358743 4-000f'\'':0 [fmt:UYVY8_1X16/1920x1080 field:none colorspace:smpte170m]'
	media-ctl -d $MEDIANODE -V ''\''csi2'\'':0 [fmt:UYVY8_1X16/1920x1080 field:none colorspace:smpte170m]'
	media-ctl -d $MEDIANODE -V ''\''csi2'\'':4 [fmt:UYVY8_1X16/1920x1080 field:none colorspace:smpte170m]'
	v4l2-ctl -v width=1920,height=1080,pixelformat=UYVY
	echo UYVY8_1X16 1920x1080 set
;;
2)
	echo 2 > /sys/module/tc358743/parameters/resolution
	if [ $? -ne 0 ]
	then
		exit 1
	fi
	media-ctl -d $MEDIANODE -V ''\''tc358743 4-000f'\'':0 [fmt:UYVY10_1X20/1920x1080 field:none colorspace:smpte170m]'
	media-ctl -d $MEDIANODE -V ''\''csi2'\'':0 [fmt:UYVY10_1X20/1920x1080 field:none colorspace:smpte170m]'
	media-ctl -d $MEDIANODE -V ''\''csi2'\'':4 [fmt:UYVY10_1X20/1920x1080 field:none colorspace:smpte170m]'
	v4l2-ctl -v width=1920,height=1080,pixelformat=UYVY
	echo UYVY8_1X20 1920x1080 set
;;
3)
	echo 3 > /sys/module/tc358743/parameters/resolution
	if [ $? -ne 0 ]
	then
		exit 1
	fi
	media-ctl -d $MEDIANODE -V ''\''tc358743 4-000f'\'':0 [fmt:UYVY8_1X16/3840x2160 field:none colorspace:smpte170m]'
	media-ctl -d $MEDIANODE -V ''\''csi2'\'':0 [fmt:UYVY8_1X16/3840x2160 field:none colorspace:smpte170m]'
	media-ctl -d $MEDIANODE -V ''\''csi2'\'':4 [fmt:UYVY8_1X16/3840x2160 field:none colorspace:smpte170m]'
	v4l2-ctl -v width=3840,height=2160,pixelformat=UYVY
	echo UYVY8_1X16 3840x2160 set
;;
4)
	echo 4 > /sys/module/tc358743/parameters/resolution
	if [ $? -ne 0 ]
	then
		exit 1
	fi
	media-ctl -d $MEDIANODE -V ''\''tc358743 4-000f'\'':0 [fmt:UYVY10_1X20/3840x2160 field:none colorspace:smpte170m]'
	media-ctl -d $MEDIANODE -V ''\''csi2'\'':0 [fmt:UYVY10_1X20/3840x2160 field:none colorspace:smpte170m]'
	media-ctl -d $MEDIANODE -V ''\''csi2'\'':4 [fmt:UYVY10_1X20/3840x2160 field:none colorspace:smpte170m]'
	v4l2-ctl -v width=3840,height=2160,pixelformat=UYVY
	echo UYVY8_1X20 3840x2160 set
;;
*)
	echo -e "\e[1;40;31mWrong parameter! Please refer to the usage below:\e[m"
	print_usage
;;
esac
