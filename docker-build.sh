#!/usr/bin/env bash
# Clean cache
# docker rmi $(docker images -a --filter=dangling=true -q)

docker build --tag=papamoose/the-forest-dedicated-server:latest .
