#!/bin/bash
set -e

GAME_DIR=/home/valheim/valheim-server
STEAM_SDK=${HOME}/.local/share/Steam

echo "=== Checking/Installing latest Valheim version ==="
steamcmd +force_install_dir ${GAME_DIR} \
         +login anonymous \
         +app_update 896660 validate \
         +quit

echo "=== Linking Steam SDK for server API ==="
mkdir -p ${HOME}/.steam/sdk64
if [ -f "${STEAM_SDK}/linux64/steamclient.so" ]; then
    cp -f ${STEAM_SDK}/linux64/steamclient.so ${HOME}/.steam/sdk64/steamclient.so
    echo "steamclient.so copied to ~/.steam/sdk64/"
else
    echo "WARNING: ${STEAM_SDK}/linux64/steamclient.so not found!"
fi

echo "=== Starting Valheim Dedicated Server ==="

cd ${GAME_DIR}
exec ./valheim_server.x86_64 -name "${SERVER_NAME}" \
     -port ${SERVER_PORT} \
     -world "${WORLD_NAME}" \
     -password "${SERVER_PASSWORD}" \
     -crossplay ${CROSSPLAY:-false} \
     -public ${PUBLIC:-1}
