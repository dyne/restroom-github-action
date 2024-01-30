#!/bin/sh

RESTROOM_CONTAINER_NAME=$1
CONTRACTS="$2"
FILES="$3"
LOGGER="$4"

echo "Starting restroom instance"
echo "Using contracts in $CONTRACTS"
export FILES_DIR="/var/files"
export LOGGER_DIR="/var/logger"

LOGGER_PARAMS=""
if [[ "$LOGGER" != "" ]]; then
  LOGGER_PARAMS="-e LOGGER_DIR -v $LOGGER:$LOGGER_DIR"
fi

FILES_PARAMS=""
if [[ "$FILES" != "" ]]; then
  FILES_PARAMS="-e FILES_DIR -v $FILES:$FILES_DIR"
fi

docker run --name $RESTROOM_CONTAINER_NAME --publish 3000:3000 $FILES_PARAMS $LOGGER_PARAMS -v "$CONTRACTS":"/app/contracts" --detach ghcr.io/dyne/restroom-mw:latest

while ! `echo -e "\x1dclose\x0d" | telnet localhost 3000 >/dev/null 2>/dev/null`; do
  sleep 1
done