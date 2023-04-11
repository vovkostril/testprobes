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
# 
docker exec -it robot-playw-1 mkdir -p results
sudo docker exec -it robot-playw-1 mkdir -p results
sudo docker exec -it robot-playw-1 ls -la && pwd
sudo docker exec -it robot-playw-1 ls -la results && pwd
sudo docker exec -it robot-playw-1 robot -d results /home/ptp_play.robot
sudo docker exec -it robot-playw-1 ls -la results && pwd
