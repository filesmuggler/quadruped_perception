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

# Jetson setup

## 1 Used hardware
### 1.1. Required hardware

For setup:
- Seeed Carier Board(Jetson-J202)
- AC/DC switching adaptor 230V/19V - supplied with teh board
- USB mouse
- USB keyboard
- extra HDMI monitor
- NVME M2 250GB disk/microSD card 64GB
- HDMI cable
- Ethernet Cable
- 1x USB-A(m) - microUSB-B(m) cable with data transmission
- 1x jumper cable F-F

### 1.2. Cable connections

Before powering up connect all the cables to the board.

Connect Jetson over usb cable to the computer with SDK manager installed.

Power-up

### 1.3. Recovery mode for flashing

To enter recovery mode before reflashing the board, you should have a female-female cable connector like for Arduino (2.54mm raster). Later when instructed by SDK Manager, you will connect pins 10(FC_REC) and 9(GND) to force recovery mode.
## 2. Nvidia SDKManager
### 2.1. Ubuntu 20.04
#### 2.1.1. Jetpack 5.1
Install all packages provided with SDK Manager - including CUDA. Use provide tool with GUI available on nvidia [webpage](https://developer.nvidia.com/sdk-manager).
### 2.2. Ubuntu 22.04
#### 2.2.1. Jetpack 5.1
Download the `tar.gz` package with docker image for ubuntu 20.04 - you won't be able to install jetpack on Jetson Xavier Nx with newer software.

Unpack to image:
```sh
sudo docker load < sdkmanager-1.9.3.10904-Ubuntu_20.04_docker.tar.gz
```
Tag unpacked image:
```sh
sudo docker tag sdkmanager:1.9.3.10904-Ubuntu_20.04 sdkmanager:latest
```
List connected devices:
```sh
sudo docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb/ -v /dev:/dev -v /media/$USER:/media/nvidia:slave --network host --rm sdkmanager --listconnected
```
> ⚠️ If no device found - power down, place jumper between the pin 9 and 10 on the Button Header. Power up again - you should see tha output to the command above.

# 3. Flashing new Jetpack

Follow guide at: [https://docs.nvidia.com/sdk-manager/sdkm-command-line-install/index.html](https://docs.nvidia.com/sdk-manager/sdkm-command-line-install/index.html)

```sh
sudo apt update && sudo apt install qemu-user-static
```

```sh
sudo docker run -it --entrypoint /bin/bash --privileged -v /dev/bus/usb:/dev/bus/usb/ -v /dev:/dev -v /media/$USER:/media/nvidia:slave --network host sdkmanager
```
In the docker container run:

```sh
sudo apt update && sudo apt install zip
```

Start downloading and follow the onscreen instructions in the container:

```sh
sdkmanager --cli install --logintype devzone --product Jetson --version 5.1.2 --target JETSON_XAVIER_NX_TARGETS --datacollection enable --staylogin true --select 'Jetson Linux' --deselect 'Jetson SDK Components' --license accept --targetos Linux --flash all
```
Wait until download finishes. Reboot the Xavier. Follow the link below for useful tips.

## 4. Set powermode to 20W6CORE
To assure the highest possible efficency of the board, set power mode to 20W with 6 cores of CPU processing. To do that, you should connect the Xavier board to the external monitor, log in and in the upper right corner you should see a drop-down list with all the power options. Choose the option __MODE 20W 6CORE__.

## 5. (OPTIONAL) Set static IP
Use the `nmcli` tool:
```sh
sudo nmcli
```
It will list all the connections the Jetson has. In our case it looks like this:
```
eth0: connected to Wired connection 1
        "eth0"
        ethernet (nvethernet), 48:B0:2D:67:98:4D, hw, mtu 1500
        ip4 default
        inet4 10.0.0.148/16
        route4 0.0.0.0/0
        route4 10.0.0.0/16
        route4 169.254.0.0/16
        inet6 fe80::6fc9:3f58:15e0:a4fb/64
        route6 fe80::/64

...
```
According to your need you should choose Wifi or Ethernet connection for setting the static IP.

Set static address for chosen connection:
```bash
sudo nmcli con mod Wired\ connection\ 1 ipv4.addr "10.0.0.148/24" gw4 "10.0.0.1" ipv4.dns "8.8.8.8,8.8.4.4" ipv4.method "manual"
```
Reboot Xavier.

> ℹ️ Pro tip: check using `nmap` tool if the chosen ip address is free for you to use.


## 6. (OPTIONAL) Install ROS Noetic

_Adapted from [Official ROS website](http://wiki.ros.org/noetic/Installation/Ubuntu)_

Setup sources list
```sh
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```
Set up keys
```
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
```
Installation
```sh
sudo apt update
sudo apt install ros-noetic-desktop-full
```
Environment setup
```sh
echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```
Install dependencies for building packages
```sh
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
sudo rosdep init
rosdep update
```


## 7. Install docker engine (if not installed by SDK Manager)

### 7.1. Remove old installations
Remove old docker engine if ever existed
```sh
sudo apt-get remove docker docker-engine docker.io containerd runc
```
### 7.2. Update sources
Update and install required packages
```sh
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```
Add Docker's official GPG key
```sh
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```
Set up repository
```sh
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
### 7.3. Install
Install
```sh
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```
### 7.4. Verify _docker_ installation
Test if docker is correctly installed
```sh
sudo docker run hello-world
```
## 8. Install docker compose plugin

```sh
sudo apt-get update
sudo apt-get install docker-compose-plugin
```

## 9. Install nvidia-docker (if not installed by SDK Manager)
Omit this step if SDK manager installation was flawless.
```sh
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```
```sh
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

## Useful links
- [SDK manager issues](https://forums.developer.nvidia.com/t/failure-to-run-sdk-manager-from-official-docker-image/168227)

# JETSON NETWORK SETUP

Add network profiles to freely communicate with Jetson both on the robot and in the lab environment.

Profiles

_Lab:_
```sh
eth0
Automatic DHCP

```

_Unitree:_
```sh
eth0
192.168.123.164/24, 192.168.123.1
```

## /etc/hosts
```
127.0.0.1       localhost
127.0.1.1       xavier
192.168.123.161 raspberrypi
192.168.123.163 mate
192.168.123.13  unitree-desktop
192.168.123.14  unitree-desktop
192.168.123.15  unitree-desktop
192.168.123.166 tabtest
192.168.123.167 alien

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

```