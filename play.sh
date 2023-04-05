#!/bin/bash
# install docker and docker compose to auto server
#
docker ps
docker compose down
docker compose up -d --no-deps --build
docker exec -it robot-playw-1 node -v
docker exec -it robot-playw-1 robot /home/ptp_play.robot
mkdir -p /home/anastasiia/robot && docker cp robot-playw-1:/home /home/anastasiia/robot
docker ps
docker compose down
