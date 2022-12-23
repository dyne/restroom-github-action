#!/bin/sh

RESTROOM_CONTAINER_NAME=$1
CONTRACTS="$2"
FILES="$3"

echo "Starting restroom instance"
echo "Using contracts in $CONTRACTS"
export FILES_DIR="/var/files"
docker run --name $RESTROOM_CONTAINER_NAME --publish 3000:3000 -e FILES_DIR -v "$FILES":"/var/files" -v "$CONTRACTS":"/app/contracts" --detach ghcr.io/dyne/restroom-mw:master
sleep 7
