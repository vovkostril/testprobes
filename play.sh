#!/bin/bash
docker ps
docker compose down
docker compose up -d --no-deps --build
docker exec -it aid-playw-1 node -v
docker exec -it aid-playw-1 robot /home/ptp_play.robot
mkdir -p /home/aid/robot && docker cp aid-playw-1:/home /home/aid/robot
docker ps
docker compose down