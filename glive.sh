#!/bin/bash
#echo $#
source print.sh
if [ 1 -ne $# ]
then
	echo -e "\e[1;40;31mParameter need! Please refer to the usage below:\e[m"
	print_usage
#	exit 1
fi

USERNAME=`whoami`
#echo $USERNAME
export DISPLAY=:0
export XAUTHORITY=/home/$USERNAME/.Xauthority
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/gstreamer-1.0

RESOLUTION=$1

case $RESOLUTION in
1)
	gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=600 ! video/x-raw,format=UYVY,width=1920,height=1080 ! videoconvert ! xvimagesink "render-rectangle=<450,-250,1020,1480>" sync=false
;;
2)
	gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=600 ! video/x-raw,format=UYVY,width=1920,height=1080 ! videoconvert ! xvimagesink "render-rectangle=<450,-250,1020,1480>"
;;
3)
	gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=300 ! video/x-raw,format=UYVY,width=3840,height=2160 ! videoconvert ! xvimagesink "render-rectangle=<1400,170,1020,1800>" sync=false
;;
4)
	#gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=300 ! video/x-raw,format=UYVY,width=3840,height=2160 ! videoconvert ! xvimagesink "render-rectangle=<1400,170,1020,1800>" sync=false
	gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=300 ! video/x-raw,format=UYVY,width=3840,height=2160 ! videoconvert ! xvimagesink "render-rectangle=<1400,170,1020,1800>" sync=false
	#gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=300 ! video/x-raw,format=$2,width=3840,height=2160 ! videoscale ! xvimagesink "render-rectangle=<1400,170,1020,1800>" sync=false
;;
5)
	gst-launch-1.0 -v v4l2src device=/dev/video0 num-buffers=300 ! video/x-raw,format=RGB,width=1920,height=1080 ! videoconvert ! xvimagesink "render-rectangle=<450,-250,1020,1480>" sync=false
;;
6)
	gst-launch-1.0 -v v4l2src device=/dev/video0  ! video/x-raw,format=RGB,width=3840,height=2160 ! videoconvert ! xvimagesink
;;
*)
	print_usage
	exit 2
;;
esac
