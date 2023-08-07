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


## Useful links
- [SDK manager issues](https://forums.developer.nvidia.com/t/failure-to-run-sdk-manager-from-official-docker-image/168227)