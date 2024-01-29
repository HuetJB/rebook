#!/bin/bash

# Basic usage : ./setup.sh
# Advanced variables :
#   INSTANCE_NAME : change the default docker compose instance name
#   URL_PORT : change the default port to 3000

# Check if docker-compose file already exist
if [ -f docker-compose.yml ]; then
    echo "/!\ ERROR : The docker-compose file already exist"
    exit 1
fi

# Define default env vars
INSTANCE_NAME="${USER}-$(basename $(pwd))"
APP_VERSION=$(git describe --tags --match 'v[0-9]*.[0-9]*.[0-9]' --dirty --always)
PYTHON_VERSION=$(cat .python-version | head -n1)

# Generate .env file
cat << EOF > .env.tmp
INSTANCE_NAME=${INSTANCE_NAME}

APP_VERSION=${APP_VERSION}

REBOOK_IMAGE=rebook:${INSTANCE_NAME}

PYTHON_VERSION=${PYTHON_VERSION}

EOF

cat deploy/env >> .env.tmp

# Construct docker compose
docker compose -p "${INSTANCE_NAME}" --env-file .env.tmp --project-directory . -f ./deploy/docker-compose.yml -f ./deploy/docker-compose-dev-override.yml config > docker-compose.yml

rm .env.tmp

echo "Instance ${INSTANCE_NAME} ready"
echo "Your docker-compose.yml file is ready to use"
echo "Once started, your installation will be available at localhost:8000"
echo
echo "\`docker compose up -d\` to start it"
