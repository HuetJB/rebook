#!/bin/bash

# Basic usage : ./setup.sh
# Advanced variables :
#   INSTANCE_NAME : change the default docker compose instance name
#   URL_PORT : change the default port to 3000

# Define default env vars
INSTANCE_NAME="${USER}-$(basename $(pwd))"
APP_VERSION=$(git describe --tags --match 'v[0-9]*.[0-9]*.[0-9]' --dirty --always)
APP_PORT=3000
REBOOK_IMAGE=pureapi:\${INSTANCE_NAME}
PYTHON_VERSION=$(cat .python-version | head -n1)

# Check if env file already exist
if [ -f .env ]; then
    echo "/!\ Warning : The env file already exist"
else
    export INSTANCE_NAME APP_VERSION APP_PORT

    # Generate .env file
    cat deploy/env.example | envsubst > .env

    echo "Env file generate please fill it at .env"
fi

echo

# Construct docker compose
docker compose -p "${INSTANCE_NAME}" --env-file .env --project-directory . -f ./deploy/docker-compose.yml -f ./deploy/docker-compose-dev-override.yml config > docker-compose.yml

echo "Instance ${INSTANCE_NAME} ready"
echo "Your docker-compose.yml file is ready to use"
echo "Once started, your installation will be available at localhost:${APP_PORT}"
echo
echo "\`docker compose up -d\` to start it"
