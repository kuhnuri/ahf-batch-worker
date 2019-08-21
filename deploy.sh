#!/usr/bin/env bash

set -e

export TAG=3.2
docker-compose build --build-arg TAG=$TAG
#docker-compose push
