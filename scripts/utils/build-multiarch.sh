#!/bin/bash
TAG=${TAG:-"${TAG_PREFIX}${NAME}"}
PLATFORM=${PLATFORM:-"linux/amd64,linux/arm64/v8,linux/arm/v7"}
EXTRA_ARGS=${EXTRA_ARGS:-"$@"}

docker buildx build \
--platform $PLATFORM \
--tag "${TAG}:${VERSION}" \
$EXTRA_ARGS \
.
