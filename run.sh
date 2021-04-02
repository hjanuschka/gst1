#!/bin/bash
set -x 
set -e


ENC1="nvh264enc bitrate=20000 qp-const=0 rc-mode=cbr-hq gop-size=50 qos=false "
ENC2="x264enc ref=4 cabac=true  key-int-max=50 quantizer=0 tune=zerolatency pass=0 bitrate=20000"



echo "Using nvh264enc"
gst-launch-1.0 filesrc location=source.mxf ! decodebin  ! deinterlace !  videoconvert ! videoscale ! videorate ! $ENC1 !  filesink location=out-hw.mp4 


echo "Using x264"
gst-launch-1.0 filesrc location=source.mxf ! decodebin  !  videoconvert ! videoscale ! videorate ! $ENC2 !  filesink location=out-sw.mp4 

exit
