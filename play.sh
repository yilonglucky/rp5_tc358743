#!/bin/bash
#echo $#
if [ 1 -ne $# ]
then
	echo Usage: $0 resolution, such as \"$0 1\" 
	exit -1
fi

USERNAME=`whoami`
echo $USERNAME
export DISPLAY=:0
export XAUTHORITY=/home/$USERNAME/.Xauthority
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/gstreamer-1.0

RESOLUTION=$1




#MEDIA=$1
#echo MEDIA=$MEDIA
#MEDIANO=$1
#
#MEDIANO=`v4l2-ctl --list-devices | grep -A 9 csi | grep /dev/media |sed 's/.*media//'`
#echo MEDIANO=$MEDIANO
#echo MEDIANODE=/dev/media$MEDIANO

#MEDIANODE="/dev/media$MEDIANO"
#echo MEDIANODE=$MEDIANODE


#media-ctl -d $MEDIANODE -p

#media-ctl -d $MEDIANODE -r

#media-ctl -d $MEDIANODE -l ''\''csi2'\'':4 -> '\''rp1-cfe-csi2_ch0'\'':0 [1]'

if [[ $RESOLUTION  -eq 1 ]]
then
	gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=600 ! video/x-raw,format=UYVY,width=1920,height=1080 ! videoconvert ! xvimagesink 
else
	if [[ $RESOLUTION -eq 2 ]]
	then
		gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=UYVY,width=1920,height=1080 ! videoconvert ! xvimagesink &
	else
		if [[ $RESOLUTION -eq 3 ]]
		then
			gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=UYVY,width=3840,height=2160 ! videoconvert ! xvimagesink &
			#gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=UYVY,width=1920,height=1080 ! videoconvert ! xvimagesink &
		else
			if [[ $RESOLUTION -eq 4 ]]
			then
				gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=UYVY,width=3840,height=2160 ! videoconvert ! xvimagesink &
			else
				echo "only 1,2,3,4 supported"
			fi
		fi
	fi
fi

