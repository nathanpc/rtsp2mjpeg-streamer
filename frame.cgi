#!/bin/sh

# Check if the required environment variables are available.
if [[ -z "${RTSP_URL}" ]]; then
	echo "Content-Type: text/plain"
	echo "Cache-Control: no-cache"
	echo ""
	echo "ERROR: Missing the required RTSP_URL environment variable."
	exit 1
fi

# Grab a snapshot.
echo "Content-Type: image/jpeg"
echo "Cache-Control: no-cache"
echo ""
ffmpeg -rtsp_transport tcp -i "${RTSP_URL}" -vframes 1 -f image2pipe -an -
