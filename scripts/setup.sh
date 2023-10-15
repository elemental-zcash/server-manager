#!/bin/bash

NETWORK_NAME="elemental_net"

if ! docker network inspect "$NETWORK_NAME" >/dev/null 2>&1; then
    echo "Creating Docker network: $NETWORK_NAME"
    docker network create -d bridge "$NETWORK_NAME"
fi

cd links
if [ ! -d ./postgres-service ]; then
    ln -s ../../postgres-service postgres-service
    ln -s ../../redis-service redis-service
    ln -s ../../sso sso
    ln -s ../../../elemental-pay/elemental-pay elemental-pay
    ln -s ../../../zpublish/platform zpublish-platform
fi

cp postgres-service/.env ../.postgres.env
cp redis-service/.env ../.redis.env
cp postgres-service/config.json ../database.config.json

source_value=$(grep '^REDIS_PSWD=' ../.redis.env | sed 's/REDIS_PSWD=//')

cp ../database.config.json sso/database.config.json
cd sso

dest_value=$(grep '^REDIS_PSWD=' .env | sed 's/REDIS_PSWD=//')

if [ ! -n "$dest_value" ] && [ -n "$source_value" ]; then
  echo "REDIS_PSWD=$source_value" >> .env
fi

cd ..
