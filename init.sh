#!/bin/bash

docker build -t flask_app_image:1.0 -f Dockerfile .
docker-compose down
docker-compose up --remove-orphans --detach