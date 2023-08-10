# Jetson setup

## Install SOEM

after installing soem add root for current user to run it

```sh
sudo setcap cap_net_admin,cap_net_raw=eip /opt/ros/melodic/bin/slaveinfo
```

## Install newer GCC

```sh
gcc -V
gcc --version
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt install gcc-10
sudo update-alternatives --remove-all gcc
sudo update-alternatives --remove-all g++
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 30
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 30
sudo update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
sudo update-alternatives --set cc /usr/bin/gcc
sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
sudo update-alternatives --set c++ /usr/bin/g++
sudo update-alternatives --config gcc
sudo update-alternatives --config g++
```

## Prepare custom description package

robot.launch
