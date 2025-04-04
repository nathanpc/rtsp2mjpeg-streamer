FROM debian:buster

# TODO: Upgrade to the latest Debian and compile VLC from source with the
# live555 plugin enabled: https://forum.videolan.org/viewtopic.php?t=157795

# Install VLC.
RUN apt update && apt install -y \
	vlc \
	bash \
	ffmpeg \
	&& apt clean && rm -rf /var/lib/apt/lists/*

# Copy the stream script.
WORKDIR /app
COPY streamer.sh .

# Fix VLC to run as root.
RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc

# Start it up.
EXPOSE 8888
CMD '/app/streamer.sh'
