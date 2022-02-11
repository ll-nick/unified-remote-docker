#!/bin/bash

docker run \
    --rm \
    -t \
    -d \
    --name="unifiedremote" \
    -p 9510:9510 \
    -p 9511:9511 \
    -p 9512:9512 \
    --device /dev/uinput \
    --volume $(pwd)/urserver.config:/home/ur/.urserver/urserver.config \
    nickll/unifiedremote:raspbian "$@"
