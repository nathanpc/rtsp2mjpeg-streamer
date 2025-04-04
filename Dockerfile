FROM debian:buster

# Install VLC.
RUN apt update && apt install -y \
	vlc \
	bash \
	ffmpeg \
	binutils \
	&& apt clean && rm -rf /var/lib/apt/lists/*

# Copy the stream script.
WORKDIR /app
COPY streamer.sh .
COPY fix-vlc.sh .

# Fix VLC to run as root.
RUN ./fix-vlc.sh

# Start it up.
EXPOSE 8888
CMD '/app/streamer.sh'
