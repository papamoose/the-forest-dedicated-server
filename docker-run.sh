#!/usr/bin/env bash
d=/opt
docker run \
  --rm \
  -d \
  -p 8766:8766/tcp \
  -p 8766:8766/udp \
  -p 27015:27015/tcp \
  -p 27015:27015/udp \
  -p 27016:27016/tcp \
  -p 27016:27016/udp \
  -v $d/theforest:/theforest \
  --name the-forest-dedicated-server \
  papamoose/the-forest-dedicated-server:latest
