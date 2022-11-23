#!/bin/sh

scriptPath_file=$(dirname "${BASH_SOURCE[0]}")
scriptPath_folder=$(realpath "${scriptPath_file}")
utils_path="${scriptPath_folder}/utils"

# Call prepare
printf "# PREPARE\n"
source ${utils_path}/prepare.sh

# Call build
printf "# BUILD\n"
build_type=${BUILD:-"ownarch"}
source ${utils_path}/build-${build_type}.sh
