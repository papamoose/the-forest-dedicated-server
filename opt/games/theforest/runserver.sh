#!/bin/bash
d=/theforest
mkdir -p ${d}/saves ${d}/config ${d}/logs

if [ ! -f ${d}/config/config.cfg ]; then
  cp /opt/games/theforest/config/config.cfg.example ${d}/config/config.cfg
fi

cd /opt/games/theforest/game
/usr/bin/xvfb-run \
  --auto-servernum \
  --server-args='-screen 0 640x480x24:32' \
  /usr/bin/wine ./TheForestDedicatedServer.exe \
    -batchmode \
    -nographics \
    -savefolderpath "${d}/saves/" \
    -configfilepath "${d}/config/config.cfg" \
    | awk NF \
    | grep -v "RenderTexture.Create failed: format unsupported - 2." \
    | sed '/^[[:space:]]*$/d'

#    | sed -n '/^Exception: NullReferenceException:*/,/\(Filename:  Line: -1\)$/{/^Exception: NullReferenceException:*/d;p}'

