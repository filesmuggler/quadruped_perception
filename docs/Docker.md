# Docker Setup

```sh
cd qp_docker
sudo docker compose build
sudo docker compose up
```

In separate terminals:
```sh
sudo docker exec -it qp-unitree-container bash
```

## Rokubi container setup
```sh
sudo docker exec -it qp-rokubi-container bash
```
Build workspace
```sh
cd rokubi_ws
mkdir src && cd src
git clone https://github.com/filesmuggler/rsl_rokubi.git
cd ..
catkin build && source devel/setup.bash
```
Change `ethercat_bus` and `ethercat_address` parameters in `setup.yaml`:
```sh
nano src/rsl_rokubi/rokubimini_ethercat_sdk/rokubimini_ethercat_cosmo/config/setup.yaml
```


Test sensors
```sh
#inside docker container
cd rokubi_ws && source devel/setup.bash
roslaunch rokubimini_ethercat_cosmo rokubimini_ethercat.launch
```

## Rokubi container run
