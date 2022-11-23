#!/bin/bash
TAG=${TAG:-"${TAG_PREFIX}${NAME}"}
EXTRA_ARGS=${EXTRA_ARGS:-"$@"}

docker build \
--tag $TAG:$VERSION \
$EXTRA_ARGS \
.
