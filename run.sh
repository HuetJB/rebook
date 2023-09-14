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

if [ ! -f docker-compose.override.local.yml ] || [ ! -f .env ] || [ ! -f ../api/config/.env ]; then
    echo -e "${RED}Before starting the instance. Please initialized the instance.${RESET}"
    echo -e "${YELLOW}Setup of instance${RESET}"

    if [ ! -f .env ]; then
        echo -e "${YELLOW}Creation of the .env file${RESET}"

        cp .env.example .env

        echo -e "${GREEN}The .env file is create (please fill it with your data)${RESET}"
    fi

    if [ ! -f ../api/config/.env ]; then
        echo -e "${YELLOW}Creation of the .env file of api${RESET}"

        cp ../api/config/.env.example ../api/config/.env

        echo -e "${GREEN}The .env file of api is create (please fill it with your data)${RESET}"
    fi

    if [ ! -f docker-compose.override.local.yml ]; then
        echo -e "${YELLOW}Creation of the docker-compose.override.local.yml file${RESET}"

        cp docker-compose.override.local.example.yml docker-compose.override.local.yml

        echo -e "${GREEN}The docker-compose.override.local.yml file is create (please fill it with your data)${RESET}"
    fi

    echo -e "${GREEN}The instance has setup with success${RESET}"
    echo -e "${YELLOW}Please fill your data in env files${RESET}"
    exit 0
fi

echo -e "${YELLOW}Check env variables...${RESET}"

check_vars() {
    # Check if the file exists
    if [ -f "$1" ] && [ -f "$2" ]; then
        # Read line by line
        while read -r line || [ -n "$line" ]; do
            # Check the format of the line using grep
            if echo "$line" | grep -Eq "^[A-Za-z0-9_]*="; then
                # Retrieve the variable name
                variable=$(echo "$line" | cut -d '=' -f 1)

                if ! grep -q "$variable=" "$2"; then
                    echo -e "${RED}Error with env files $1 and $2 : $variable is not define in $2${RESET}"
                    exit 1
                fi
            fi
        done < "$1"

        while read -r line || [ -n "$line" ]; do
            # Check the format of the line using grep
            if echo "$line" | grep -Eq "^[A-Za-z0-9_]*="; then
                # Retrieve the variable name
                variable=$(echo "$line" | cut -d '=' -f 1)

                if ! grep -q "$variable=" "$1"; then
                    echo -e "${RED}Error with env files $1 and $2 : $variable is define but it should not be in $1${RESET}"
                    exit 1
                fi
            fi
        done < "$2"

        echo -e "${GREEN}Env files $1 and $2 are OK${RESET}"
    elif [ ! -f "$1" ]; then
        echo -e "${RED}File $1 does not exist${RESET}"
        exit 1
    else
        echo -e "${RED}File $2 does not exist${RESET}"
        exit 1
    fi
}

check_vars ".env.example" ".env"

APP_ENV=$(grep "APP_ENV" .env | cut -d '=' -f2)
INSTANCE_NAME=$(grep "INSTANCE_NAME" .env | cut -d '=' -f2)

if [ ! "$APP_ENV" = "prod" ] && [ ! "$APP_ENV" = "dev" ]; then
    echo -e "${RED}The environment type of your instance is not valid${RESET}"
    exit 1
fi

echo -e "${YELLOW}Welcome to the utility for the instance '$INSTANCE_NAME'${RESET}"

start_instance() {
    ./compose_dev.sh build --pull

    ./compose_dev.sh up -d
}

stop_instance() {
    ./compose_dev.sh down
}

if [ "$(docker ps -q -f name=rebook-$INSTANCE_NAME)" ]; then
    echo -e "${YELLOW}The instance '$INSTANCE_NAME' is already started${RESET}"
    
    echo -e "${YELLOW}Do you want to stop or restart the project (stop/restart)${RESET}"
    read USER_INPUT

    if [ "$USER_INPUT" = "stop" ]; then
        echo -e "${YELLOW}Stop the instance '$INSTANCE_NAME'${RESET}"

        stop_instance

        echo -e "${GREEN}The instance '$INSTANCE_NAME' stopped with success${RESET}"
    elif [ "$USER_INPUT" = "restart" ]; then
        echo -e "${YELLOW}Restart the instance '$INSTANCE_NAME'${RESET}"
        
        stop_instance
        sleep 1
        start_instance

        echo -e "${GREEN}The instance '$INSTANCE_NAME' restarted with success${RESET}"
    else
        echo -e "${RED}You did not answer the question correctly (only stop or restart)${RESET}"
        echo -e "${RED}The instance '$INSTANCE_NAME' has not been stopped or restarted${RESET}"
        exit 1
    fi
else
    echo -e "${YELLOW}The instance '$INSTANCE_NAME' is not started${RESET}"
    echo -e "${YELLOW}You want to start it ? (y/n)${RESET}"
    read USER_INPUT

    if [ "$USER_INPUT" = "y" ] || [ "$USER_INPUT" = "Y" ] || [ "$USER_INPUT" = "o" ] || [ "$USER_INPUT" = "O" ]; then
        echo -e "${YELLOW}Start the instance '$INSTANCE_NAME'${RESET}"

        start_instance

        echo -e "${GREEN}The instance '$INSTANCE_NAME' started with success${RESET}"
    else
        echo -e "${RED}The instance '$INSTANCE_NAME' has not been started${RESET}"
        exit 1
    fi
fi
