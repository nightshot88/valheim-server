FROM steamcmd/steamcmd:ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
    lib32gcc-s1 \
    libc6 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Basis-Image hat bereits einen User mit UID 1000 - wir legen KEINEN neuen an,
# sondern nutzen die ID direkt numerisch (USER 1000:1000 weiter unten)

# Verzeichnisse als root anlegen und Rechte an UID 1000 übergeben
RUN mkdir -p /home/valheim/valheim-server \
             /home/valheim/.config/unity3d/IronGate/Valheim \
    && chown -R 1000:1000 /home/valheim

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown 1000:1000 /entrypoint.sh

ENV HOME=/home/valheim
USER 1000:1000
WORKDIR /home/valheim

EXPOSE 2456-2458/udp

ENTRYPOINT ["/entrypoint.sh"]
