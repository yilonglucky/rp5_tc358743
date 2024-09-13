#!/bin/bash
#echo $#
source print.sh
if [ 1 -ne $# ]
then
	#echo Usage: $0 resolution, such as \"$0 1\"
	print_usage
	exit 1
fi

USERNAME=`whoami`
echo $USERNAME
export DISPLAY=:0
export XAUTHORITY=/home/$USERNAME/.Xauthority
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/gstreamer-1.0

RESOLUTION=$1
CNT=600

case $RESOLUTION in
1)
	gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=$CNT ! video/x-raw,format=UYVY,width=1920,height=1080 ! videoconvert ! xvimagesink
;;
2)
	gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=UYVY,width=1920,height=1080 ! videoconvert ! xvimagesink
;;
3)
	gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=UYVY,width=3840,height=2160 ! videoconvert ! xvimagesink
	#gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=UYVY,width=1920,height=1080 ! videoconvert ! xvimagesink
;;
4)
	gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=UYVY,width=3840,height=2160 ! videoconvert ! xvimagesink
;;
5)
	gst-launch-1.0 v4l2src device=/dev/video0 num-buffers=$CNT ! video/x-raw,format=RGB,width=1920,height=1080 ! videoconvert ! xvimagesink
	#gst-launch-1.0 v4l2src device=/dev/video0 num-buffers=$CNT ! video/x-raw,format=RGB,width=1920,height=1080 ! videoconvert ! autovideosink
;;
6)
	gst-launch-1.0 v4l2src device=/dev/video0  ! video/x-raw,format=RGB,width=3840,height=2160 ! videoconvert ! xvimagesink
;;
*)
	print_usage
	exit 2
;;
esac
