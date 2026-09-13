#!/bin/bash
set -e

GAME_DIR=/home/valheim/valheim-server

echo "=== Checking/Installing latest Valheim version ==="
steamcmd +force_install_dir ${GAME_DIR} \
         +login anonymous \
         +app_update 896660 validate \
         +quit

echo "=== Starting Valheim Dedicated Server ==="

cd ${GAME_DIR}
exec ./valheim_server.x86_64 -name "${SERVER_NAME}" \
     -port ${SERVER_PORT} \
     -world "${WORLD_NAME}" \
     -password "${SERVER_PASSWORD}" \
     -crossplay ${CROSSPLAY:-false} \
     -public ${PUBLIC:-1}
