#!/bin/sh

docker run -it -e DISPLAY=host.docker.internal:0.0 -e LIBGL_ALWAYS_INDRIECT=1 mluckydwyer/hw-ci:latest bash