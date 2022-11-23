#!/bin/sh

# --- VARIABLES ---
# Load variables
source $PWD/info.env

# Check if certain vars are overwritten, set them if missing
if [ "${NAME}" = "" ]; then
    NAME="$(basename $PWD)"
fi
export NAME
printf "Name: ${NAME}\n"


# --- SOURCES ---
alias git="git -C .build/repository"
# Get sources locally
if ! [ -d .build/repository ]; then
    git clone "${GIT_REPOSITORY}" .build/repository
else
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
