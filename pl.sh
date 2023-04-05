#!/bin/bash
# install docker and docker compose to auto server
#
docker ps
# docker compose down
# docker compose up -d --no-deps --build
docker exec -it robot-playw-1 node -v
# docker exec -it robot-playw-1 robot /home/ptp_play.robot
mkdir -p /home/anastasiia/robo_t_results && docker cp robot-playw-1:/home /home/anastasiia/robo_t_results
#zip
docker ps
# docker compose down
# send results
# move to trash
