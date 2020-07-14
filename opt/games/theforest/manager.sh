#!/bin/bash

gamepath="/opt/games/theforest"

function is_running() {
  ec=$(pgrep "TheForestDedicatedServer.exe" > /dev/null 2>&1; echo $?)
  if [ $ec -eq 0 ]; then
    true
  else
    false
  fi
}

function install_game_server() {
  ec=$(supervisorctl status theforest-update | grep -q RUNNING; echo $?)
  if [[ $ec != 0 ]]; then
    supervisorctl start theforest-update
  fi
}

function stop_server() {
  supervisorctl stop theforest-update
}

function start_server() {
  if is_running; then
    #echo ">> INFO: Server running, skipping start"
    return
  else
    ec=$(supervisorctl status theforest-server | grep -q RUNNING ; echo $?)
    if [[ $ec != 0 ]]; then
      #rm -f /tmp/.X1-lock
      supervisorctl start theforest-server
    fi
  fi
}

function main() {
  while true; do
    # Check if server is installed, if not try again
    if [ ! -f "${gamepath}/game/TheForestDedicatedServer.exe" ]; then
      install_game_server
    else
      start_server
    fi
    sleep 15
  done
}

main
