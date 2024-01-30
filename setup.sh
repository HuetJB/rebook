#!/bin/bash

# Basic usage : ./setup.sh

password_generator() {
    tr -dc 'A-Za-z0-9' </dev/urandom | head -c $1
}

# Define default env vars
INSTANCE_NAME="${USER}-$(basename $(pwd))"
APP_VERSION=$(git describe --tags --match 'v[0-9]*.[0-9]*.[0-9]' --dirty --always)
PYTHON_VERSION=$(cat .python-version | head -n1)
DJANGO_ALLOWED_HOSTS="localhost 127.0.0.1 0.0.0.0 [::1]"
REBOOK_IMAGE="rebook:${INSTANCE_NAME}"
APP_PORT=8000
DB_PASSWORD=$(password_generator 50)
DJANGO_SECRET_KEY=$(password_generator 100)

export INSTANCE_NAME APP_VERSION PYTHON_VERSION DJANGO_ALLOWED_HOSTS REBOOK_IMAGE APP_PORT DB_PASSWORD DJANGO_SECRET_KEY

# Generate .env file
envsubst < deploy/env > .env.tmp

# Construct docker compose
docker compose -p "${INSTANCE_NAME}" --env-file .env.tmp --project-directory . -f ./deploy/docker-compose.yml -f ./deploy/docker-compose-dev-override.yml config > docker-compose.yml

rm .env.tmp

echo "Instance ${INSTANCE_NAME} ready"
echo "Your docker-compose.yml file is ready to use"
echo "Once started, your installation will be available at localhost:8000"
echo
echo "\`docker compose up -d\` to start it"
