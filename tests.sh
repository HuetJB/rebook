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

INSTANCE_NAME=$(grep "INSTANCE_NAME" .env | cut -d '=' -f2)

echo -e "${YELLOW}Test code with pytest...${RESET}"

docker exec rebook-$INSTANCE_NAME pytest --verbose

echo ""
echo -e "${YELLOW}Test code with mypy...${RESET}"

docker exec rebook-$INSTANCE_NAME mypy --config-file=app/pyproject.toml app

echo ""
echo -e "${YELLOW}Test code with flake8...${RESET}"

docker exec rebook-$INSTANCE_NAME flake8 --toml-config=app/pyproject.toml app