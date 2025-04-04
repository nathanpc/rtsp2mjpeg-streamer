# RTSP to MJPEG Streamer

A Docker container to provide a middleware that converts an RTSP stream into an
MJPEG HTTP feed for applications such as Octoprint.

## Configuration

In order to deploy this application all you need is a simple
`docker-compose.yml` with the following contents:

```yaml
---
services:
  3dprinter:
    image: 'ghcr.io/nathanpc/rtsp2mjpeg-streamer:main'
    ports:
      - '8805:8888'
    environment:
      RTSP_URL: 'rtsp://test.stream.lan:554/test'
```

## License

This library is free software; you may redistribute and/or modify it under the
terms of the [Mozilla Public License 2.0](https://www.mozilla.org/en-US/MPL/2.0/).
