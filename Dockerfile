FROM steamcmd/steamcmd:ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    lib32gcc-s1 \
    libc6 \
    && rm -rf /var/lib/apt/lists/*

# Noch als root: User anlegen, Dateien kopieren, Rechte setzen
RUN useradd -m valheim
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Erst jetzt zum Server-User wechseln
USER valheim
WORKDIR /home/valheim

ENV GAME_DIR=/home/valheim/valheim-server
RUN mkdir -p ${GAME_DIR}

EXPOSE 2456-2458/udp

ENTRYPOINT ["/entrypoint.sh"]
