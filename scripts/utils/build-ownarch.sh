#!/bin/bash

docker build \
--tag $TAG:latest \
--tag $TAG:$VERSION \
$EXTRA_ARGS \
"$WORKDIR"
