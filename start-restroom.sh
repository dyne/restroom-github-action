#!/bin/sh

RESTROOM_CONTAINER_NAME=$1
CONTRACTS="$2"

echo "Starting restroom instance"
echo "Using contracts in $CONTRACTS"
docker run --name $RESTROOM_CONTAINER_NAME --publish 3000:3000 -v "$CONTRACTS":"/app/contracts" --detach ghcr.io/albertolerda/restroom-github-action:main
sleep 7

