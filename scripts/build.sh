#!/bin/sh

scriptPath_file=$(dirname "${BASH_SOURCE[0]}")
scriptPath_folder=$(realpath "${scriptPath_file}")
utils_path="${scriptPath_folder}/utils"

WORKDIR=${1:-$PWD}
WORKDIR=$(realpath "$WORKDIR")

# -- VARIABLES --
# Store original path
ORIGINALDIR=$PWD

# Get args without path
EXTRA_ARGS="${@:2}"

TAG=${TAG:-"${TAG_PREFIX}${NAME}"}


# Call prepare
printf "# PREPARE\n"
source ${utils_path}/prepare.sh

# Call build
printf "# BUILD\n"
build_type=${BUILD:-"ownarch"}
source ${utils_path}/build-${build_type}.sh


# Switch back to original path
cd $ORIGINALDIR
