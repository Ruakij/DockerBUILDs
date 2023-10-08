#!/bin/bash

# --- VARIABLES ---
# Load variables
source $WORKDIR/info.env

# Check if certain vars are overwritten, set them if missing
if [ "${NAME}" = "" ]; then
    NAME="$(basename $WORKDIR)"
fi
export NAME
printf "Name: ${NAME}\n"

repositoryFolder="$WORKDIR/.build/repository"

# --- SOURCES ---
# Get sources locally
if ! [ -d "$repositoryFolder" ]; then
    git clone "${GIT_REPOSITORY}" "$repositoryFolder"
    cloned=True
fi

# Change into repository
cd "$repositoryFolder"

if [ "$cloned" != True ]; then
    # Checkout default-branch in case GIT_CHECKOUT was different
    defaultBranch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    git checkout "${defaultBranch}"

    git pull # Get changes
fi

# Checkout when set
if [ "$GIT_CHECKOUT" != "" ]; then
    # Handle special directives
    if [ "$GIT_CHECKOUT" = "latest-tag" ]; then
        GIT_CHECKOUT=$(git describe --tags $(git rev-list --tags --max-count=1)) # Get latest tag
    fi

    git checkout $GIT_CHECKOUT
fi

# --- VERSION ---
# When not set
if [ "$GIT_CHECKOUT" == "" ]; then
    # Get current version to build
    VERSION=$(git describe --tags --long)
    if [ $? -ne 0 ]; then
        VERSION=$(git rev-parse HEAD)
    fi
    export VERSION
fi
printf "Version: ${VERSION}\n"

# --- TAGS ---
IFS='-.' read -ra ADDR <<<"$VERSION"

TAG_VERS=("latest")
currentTag="${ADDR[0]}"
TAG_VERS+=("$currentTag")

for i in $(seq 1 $((${#ADDR[@]} - 1))); do
    delimiter="."
    if [[ $VERSION == *"${currentTag}-${ADDR[$i]}"* ]]; then
        delimiter="-"
    fi

    currentTag="${currentTag}${delimiter}${ADDR[$i]}"
    TAG_VERS+=("$currentTag")
done

# Generate TAG_VERS_ARG
printf "TAG_VERS:\n"
for tag_ver in "${TAG_VERS[@]}"; do
    TAG="${TAGPREFIX}${NAME}:${tag_ver}"
    TAGS_ARG="$TAGS_ARG --tag $TAG"
    echo "- $TAG"
done
