#!/bin/bash
set -e

GAME_DIR=/home/valheim/valheim-server

echo "=== Checking/Installing latest Valheim version ==="
steamcmd +force_install_dir ${GAME_DIR} \
         +login anonymous \
         +app_update 896660 validate \
         +quit

# Steam-API-Bibliotheken in GAME_DIR symlinken (falls nicht vorhanden)
if [ ! -f "${GAME_DIR}/steam_api64.so" ]; then
    ln -sf /home/valheim/.local/share/Steam/ubuntu12_64/steam_api64.so ${GAME_DIR}/steam_api64.so
fi

echo "=== Starting Valheim Dedicated Server ==="

cd ${GAME_DIR}
exec ./valheim_server.x86_64 -name "${SERVER_NAME}" \
     -port ${SERVER_PORT} \
     -world "${WORLD_NAME}" \
     -password "${SERVER_PASSWORD}" \
     -crossplay ${CROSSPLAY:-false} \
     -public ${PUBLIC:-1}
