# https://github.com/r15ch13/arkcluster-base
FROM r15ch13/arkcluster-base:latest

LABEL org.label-schema.maintainer="Richard Kuhnt <r15ch13+git@gmail.com>" \
      org.label-schema.description="ARK Cluster Image" \
      org.label-schema.url="https://github.com/r15ch13/arkcluster" \
      org.label-schema.vcs-url="https://github.com/r15ch13/arkcluster" \
      org.label-schema.schema-version="1.0.0-rc1"

# Expose environment variables
ENV CRON_AUTO_UPDATE="0 */3 * * *" \
    CRON_AUTO_BACKUP="0 */1 * * *" \
    UPDATEONSTART=1 \
    BACKUPONSTART=1 \
    BACKUPONSTOP=1 \
    WARNONSTOP=1 \
    USER_ID=1000 \
    GROUP_ID=1000 \
    TZ=UTC \
    MAX_BACKUP_SIZE=500 \
    SERVERMAP="TheIsland" \
    SESSION_NAME="ARK Docker" \
    MAX_PLAYERS=15 \
    RCON_ENABLE="True" \
    RCON_PORT=32330 \
    GAME_PORT=7778 \
    QUERY_PORT=27015 \
    RAW_SOCKETS="False" \
    SERVER_PASSWORD="" \
    ADMIN_PASSWORD="" \
    SPECTATOR_PASSWORD="" \
    MODS="" \
    CLUSTER_ID="keepmesecret" \
    KILL_PROCESS_TIMEOUT=300 \
    KILL_ALL_PROCESSES_TIMEOUT=300 \
    ALT_SAVE_DIR=""

RUN mkdir -p /etc/service/arkcluster
COPY run.sh /etc/service/arkcluster/run
RUN chmod +x /etc/service/arkcluster/run
ADD /home/steam/ARK/ShooterGame /ark/server/

COPY crontab /home/steam/crontab

COPY arkmanager.cfg /ark/arkmanager/arkmanager.cfg
COPY arkmanager-user.cfg /home/steam/arkmanager-user.cfg

VOLUME /ark /ark_server /cluster 
WORKDIR /ark
