#!/bin/bash
PLATFORM=${PLATFORM:-"linux/amd64,linux/arm64/v8,linux/arm/v7"}

docker buildx build \
    --platform $PLATFORM \
    $TAGS_ARG \
    $EXTRA_ARGS \
    $WORKDIR
