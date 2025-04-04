#!/bin/sh

# Check if the required environment variables are available.
if [[ -z "${RTSP_URL}" ]]; then
	echo "Content-Type: text/plain"
	echo "Cache-Control: no-cache"
	echo ""
	echo "ERROR: Missing the required RTSP_URL environment variable."
	exit 1
fi

# Stream out.
echo "Content-Type: multipart/x-mixed-replace;boundary=ffmpeg"
echo "Cache-Control: no-cache"
echo ""
ffmpeg -rtsp_transport tcp -i "${RTSP_URL}" -c:v mjpeg -q:v 1 -f mpjpeg -an -
