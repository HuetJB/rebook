#!/bin/sh

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'

echo "${YELLOW}Lancement du script pour l'initialisation du projet ReBook${RESET}"
echo "${YELLOW}-> npm install du backend${RESET}"

cd ./backend

npm install

cd ..

echo "${YELLOW}-> npm install du frontend${RESET}"

cd ./frontend

npm install

cd ..

echo "${YELLOW}-> création du docker-compose${RESET}"

docker-compose build