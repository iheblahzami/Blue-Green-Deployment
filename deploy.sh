#!/bin/bash

set -e

ACTIVE=$(docker exec nginx cat /etc/nginx/conf.d/default.conf | grep proxy_pass)

if [[ $ACTIVE == *blue* ]]; then
    TARGET=green
    CONF=green.conf
else
    TARGET=blue
    CONF=blue.conf
fi

echo "Deploying to $TARGET"

docker compose build $TARGET
docker compose up -d $TARGET

sleep 10

docker exec nginx curl -f http://$TARGET:3000/health

cp nginx/$CONF nginx/active.conf

docker exec nginx nginx -s reload

echo "Deployment successful"
