FROM alpine:3

# Install dependencies.
RUN apk update && apk add \
	lighttpd \
    ffmpeg \
    curl \
    sed \
	&& rm -rf /var/cache/apk/*

# Configure HTTP server.
COPY mod_cgi.conf /etc/lighttpd/mod_cgi.conf
RUN sed -i 's/#    "mod_alias",/    "mod_alias",/' \
	/etc/lighttpd/lighttpd.conf
RUN sed -i 's/#    "mod_setenv",/    "mod_setenv",/' \
	/etc/lighttpd/lighttpd.conf
RUN sed -i 's/#   include "mod_cgi.conf"/include "mod_cgi.conf"/' \
	/etc/lighttpd/lighttpd.conf
RUN mkdir /var/www/localhost/cgi-bin

# Copy scripts.
WORKDIR /var/www/localhost/cgi-bin
COPY index.html /var/www/localhost/htdocs/index.html
COPY *.cgi .

# Check every minute if lighttpd responds within 1 second and update container
# health status accordingly.
HEALTHCHECK --interval=1m --timeout=1s CMD curl -f http://localhost/ || exit 1

# Start it up.
EXPOSE 80
ENTRYPOINT [ "/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]
