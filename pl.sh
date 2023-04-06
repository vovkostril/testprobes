#!/bin/bash
# install docker and docker compose to auto server
#
docker ps
# docker compose down
# docker compose up -d --no-deps --build
docker exec -it robot-playw-1 node -v
docker exec -it robot-playw-1 ls -la && pwd
docker exec -it robot-playw-1 mkdir -p results
docker exec -it robot-playw-1 ls -la && pwd
docker exec -it robot-playw-1 robot -d results /home/test_play.robot
mkdir -p /home/anastasiia/robo_t_results && docker cp robot-playw-1:/results /home/anastasiia/robo_t_results
#zip
zip -r playw_result.zip  /home/anastasiia/robo_t_results/home
docker ps
# docker compose down
# send results
python3 m.py
# move to trash
