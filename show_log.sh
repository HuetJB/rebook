#!/bin/bash

RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
RESET="\e[0m"

# get project folder path
PROJECT_PATH=$(readlink -f $0)
PROJECT_PATH=$(echo $PROJECT_PATH | sed 's/\/[^\/]*$//')

# if PROJECT_PATH contain a space 
if [[ $PROJECT_PATH = *" "* ]]; then
    echo -e "${RED}The project path contain a space. Please move the project in a path without space.${RESET}"
    exit 1
fi

cd $PROJECT_PATH/config

./compose_dev.sh logs -f