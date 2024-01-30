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

IP=`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $RESTROOM_CONTAINER_NAME`

while ! nc -z $IP 3000; do   
  echo "$IP is not up"
  sleep 1
done
