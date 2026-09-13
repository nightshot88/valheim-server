FROM steamcmd/steamcmd:ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    lib32gcc-s1 \
    libc6 \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/valheim/valheim-server \
             /home/valheim/.config/unity3d/IronGate/Valheim \
    && chown -R 1000:1000 /home/valheim

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown 1000:1000 /entrypoint.sh

ENV HOME=/home/valheim
ENV LD_LIBRARY_PATH=/home/valheim/.local/share/Steam/ubuntu12_64:$LD_LIBRARY_PATH
ENV STEAM_APPID=896660

USER 1000:1000
WORKDIR /home/valheim

EXPOSE 2456-2458/udp

ENTRYPOINT ["/entrypoint.sh"]
