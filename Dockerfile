FROM steamcmd/steamcmd:ubuntu

# Dependencies for Valheim Server
RUN apt-get update && apt-get install -y --no-install-recommends \
    lib32gcc-s1 \
    libc6 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create valheim user with custom UID/GID to avoid conflicts
RUN groupadd -g 1500 valheim && \
    useradd -m -u 1500 -g 1500 valheim

# Create game directory and set permissions
WORKDIR /home/valheim
RUN mkdir -p /home/valheim/valheim-server && \
    chown -R valheim:valheim /home/valheim

# Copy entrypoint before switching user
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    chown valheim:valheim /entrypoint.sh

# Switch to non-root user
USER valheim

# Expose ports
EXPOSE 2456-2458/udp

ENTRYPOINT ["/entrypoint.sh"]
