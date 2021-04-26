FROM ubuntu:20.04

LABEL maintainer="Philip Kauffman"

ENV DEBIAN_FRONTEND=noninteractive 

RUN dpkg --add-architecture i386

RUN { \
      echo steamcmd steam/purge note; \
      echo steamcmd steam/license note; \
      echo steamcmd steam/question select 'I AGREE'; \
    } | debconf-set-selections

RUN apt-get update \
    && apt-get install -y \
    supervisor \
    xvfb \
    winbind \
    wine-stable \
    steamcmd:i386

RUN apt-get clean -y

RUN mkdir -p /opt/games/theforest/game /opt/games/theforest/logs

COPY . ./

RUN chmod +x /opt/games/theforest/server.sh /opt/games/theforest/manager.sh

EXPOSE 8766/tcp 8766/udp 27015/tcp 27015/udp 27016/tcp 27016/udp

VOLUME ["/theforest"]

CMD ["supervisord"]
