#!/bin/bash

docker build \
    $TAGS_ARG \
    $EXTRA_ARGS \
    "$WORKDIR"
