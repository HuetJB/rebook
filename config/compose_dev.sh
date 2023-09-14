#!/bin/bash

INSTANCE_NAME=$(grep "INSTANCE_NAME" .env | cut -d '=' -f2)

docker-compose --project-name rebook-$INSTANCE_NAME -f docker-compose.yml -f docker-compose.override.dev.yml -f docker-compose.override.local.yml --env-file .env $@

# ./compose_dev up -d --build
# ./compose_dev restart
# ./compose_dev down
# ./compose_dev logs -f