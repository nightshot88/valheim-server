FROM steamcmd/steamcmd:ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    lib32gcc-s1 \
    libc6 \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m valheim
USER valheim
WORKDIR /home/valheim

ENV GAME_DIR=/home/valheim/valheim-server
RUN mkdir -p ${GAME_DIR}

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 2456-2458/udp

ENTRYPOINT ["/entrypoint.sh"]
