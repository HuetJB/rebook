#!/bin/bash

# Basic usage : ./setup.sh

if [ ! -f .env ]; then
    password_generator() {
        tr -dc 'A-Za-z0-9' </dev/urandom | head -c $1
    }

    # Define generated env vars
    export INSTANCE_NAME="${USER}-$(basename $(pwd))"
    export APP_VERSION=dev-${INSTANCE_NAME}
    export APP_URL="localhost"
    export APP_SCHEME="http"
    export PYTHON_VERSION=$(cat .python-version | head -n1)
    export DJANGO_ALLOWED_HOSTS="localhost 127.0.0.1 0.0.0.0 [::1]"
    export REBOOK_IMAGE="rebook:${INSTANCE_NAME}"
    export APP_PORT=8000
    export DB_USERNAME=db_user_${INSTANCE_NAME}
    export DB_DATABASE=db_${INSTANCE_NAME}
    export DB_PASSWORD=$(password_generator 50)
    export DJANGO_SECRET_KEY=$(password_generator 100)

    envsubst < ./deploy/env > .env

    echo "The .env file is generate. Please fill it before re-running this script"
    exit 1
fi

source .env

# Construct docker compose
docker compose -p "${INSTANCE_NAME}" --project-directory . -f ./deploy/docker-compose.yml -f ./deploy/docker-compose-dev-override.yml config > docker-compose.yml

sed -i -e "s#$(pwd)#.#g" docker-compose.yml

echo "Instance ${INSTANCE_NAME} ready"
echo "Your docker-compose.yml file is ready to use"
echo "Once started, your installation will be available at localhost:8000"
echo
echo "\`docker compose up -d\` to start it"
