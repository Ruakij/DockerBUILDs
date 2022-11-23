#!/bin/sh

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

    git pull        # Get changes
fi

# Checkout when set
if [ "$GIT_CHECKOUT" != "" ]; then
    # Handle special directives
    if [ "$GIT_CHECKOUT" = "latest-tag" ]; then
        GIT_CHECKOUT=$(git describe --tags `git rev-list --tags --max-count=1`)     # Get latest tag
    fi

    git checkout $GIT_CHECKOUT
fi


# --- VERSION ---
# Get current version to build
VERSION=$(git describe --tags --long)
if [ $? -ne 0 ]; then
    VERSION=$(git rev-parse HEAD)
fi
export VERSION
printf "Version: ${VERSION}\n"

TAG=${TAG:-"${TAG_PREFIX}${NAME}"}
printf "> ${TAG}\n"
