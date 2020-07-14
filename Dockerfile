FROM ubuntu:20.04

LABEL maintainer="Philip Kauffman"

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update \
    && apt-get install -y software-properties-common

RUN add-apt-repository universe \
    && add-apt-repository multiverse

RUN dpkg --add-architecture i386

RUN apt-get install -y locales \
    && /usr/sbin/locale-gen en_US.UTF-8 \
    && /usr/sbin/update-locale LANG=en_US.UTF-8

RUN apt-get update \
    && apt-get install -y \
    supervisor \
    xvfb \
    winbind \
    wine-stable

RUN { \
      echo steamcmd steam/purge note; \
      echo steamcmd steam/license note; \
      echo steamcmd steam/question select 'I AGREE'; \
    } | debconf-set-selections

RUN apt-get install -y steamcmd:i386

RUN apt-get autoremove -y

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
    && echo $TIMEZONE > /etc/timezone

RUN mkdir -p /opt/games/theforest/game /opt/games/theforest/logs

RUN /usr/games/steamcmd \
    +@sSteamCmdForcePlatformType windows \
    +login anonymous \
    +force_install_dir /opt/games/theforest/game \
    +app_update 556450 validate \
    +quit

COPY . ./

RUN chmod +x /opt/games/theforest/runserver.sh

EXPOSE 8766/tcp 8766/udp 27015/tcp 27015/udp 27016/tcp 27016/udp

VOLUME ["/theforest"]

CMD ["supervisord"]
