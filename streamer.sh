#!/bin/bash

# Check if the required environment variables are available.
if [[ -z "${RTSP_URL}" ]]; then
	echo "ERROR: Missing the required RTSP_URL environment variable."
	exit 1
fi

# Global settings.
stream_target=":8888"
fps=5

# Start up VLC
vlc -vvv --intf=dummy --no-audio "${RTSP_URL}" --sout "#transcode{vcodec=mjpg,fps=${fps},venc=ffmpeg{strict=-2,threads=1},scale=1.0,acodec=none}:standard{access=http{mime=multipart/x-mixed-replace;boundary=--7b3cc56e5f51db803f790dad720ed50a},mux=mpjpeg,dst=${stream_target}}" --network-caching=50 --sout-mux-caching=50 --file-caching=50 --live-caching=50
