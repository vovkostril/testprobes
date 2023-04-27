!/bin/bash
sudo docker ps
sudo docker exec -it robot-playw-1 node -v
sudo docker exec -it robot-playw-1 ls -la && pwd
sudo docker exec -it robot-playw-1 mkdir -p results
sudo docker exec -it robot-playw-1 ls -la && pwd
sudo docker exec -it robot-playw-1 robot -d results /home/test_play.robot
sudo mkdir -p /home/anastasiia/robo_t_results && docker cp robot-playw-1:/results /home/anastasiia/robo_t_results
#zip
docker ps
python3 m.py


############################
 history
 1246  sudo mkdir -p /home/anastasiia/robot/results && sudo docker cp robot-playw-1:/results /home/anastasiia/robot/results
 1247  ls -la
 1248  cd ../
 1249  ls -la
 1250  cd tests
 1251  ls -la
 1252  cd Collection/
 1253  ls -la
 1254  sudo cp poe-latest-2023-4-25.zip poe-latest-2023-4-25.zip_2
 1255  cd ../
 1256  sudo python3 tests.py
 1257  ssh admin@192.168.20.120
 1258  ssh admin@192.168.20.121
