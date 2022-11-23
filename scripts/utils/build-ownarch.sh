#!/bin/bash
TAG=${TAG:-"${TAG_PREFIX}${NAME}"}

docker build \
--tag $TAG:latest \
--tag $TAG:$VERSION \
$EXTRA_ARGS \
"$WORKDIR"
