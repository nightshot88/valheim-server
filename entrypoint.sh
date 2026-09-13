#!/bin/bash
set -e

echo "=== Setting up permissions ==="

# Fix permissions on mounted volumes if they exist
if [ -d "/data" ]; then
    chown -R valheim:valheim /data || true
fi

# Create necessary directories
mkdir -p /home/valheim/.config/unity3d/IronGate/Valheim
chown -R valheim:valheim /home/valheim/.config

echo "=== Checking/Installing Valheim version ==="
steamcmd +force_install_dir /home/valheim/valheim-server \
         +login anonymous \
         +app_update 896660 validate \
         +quit

echo "=== Starting Valheim Dedicated Server ==="

cd /home/valheim/valheim-server
exec su -c './valheim_server.x86_64 -name "${SERVER_NAME}" \
     -port ${SERVER_PORT} \
     -world "${WORLD_NAME}" \
     -password "${SERVER_PASSWORD}" \
     -crossplay ${CROSSPLAY:-false} \
     -public ${PUBLIC:-1}' valheim
