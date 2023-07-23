# Docker Setup

## Reinstall newer version of docker compose to NVidia Jetson

Remove old docker installation:
```sh
sudo apt-get remove docker docker-engine docker.io containerd runc
```
Install new docker from `edge` channel
```sh
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   edge"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
```
Verify:
```sh
docker version
```

### References
- Original guide at: [https://blog.hypriot.com/post/nvidia-jetson-nano-upgrade-docker](https://blog.hypriot.com/post/nvidia-jetson-nano-upgrade-docker/)

## Build images (Jetson)
```sh
cd quadruped_perception
git checkout noepotic-jetson
cd qp_docker
sudo docker pull ubuntu:20.04
sudo docker compose build
```

## Run containers (Jetson)
```sh
sudo docker compose up
```

In separate terminals run following commands.
```sh
sudo docker exec -it qp-unitree-container bash
```
```sh
sudo docker exec -it qp-rokubi-container bash
```
```sh
sudo docker exec -it qp-xsense-container bash
```
```sh
sudo docker exec -it qp-ublox-container bash
```

