# How to setup xsense 

## PC

1. Download manager package for your device - our is MTi 300, which falls into (MTi1 MTi600 MTi10/1000 series).
[Link](https://base.xsens.com/s/article/Installing-the-correct-Software-Suite-for-different-generation-products?language=en_US)
2. Unpack the archive
3. Install required libraries before:
    ```sh
    sudo apt update
    sudo apt install sharutils liblapacke libdouble-conversion-dev
    wget http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3.2_amd64.deb
    sudo apt-get install ./libicu60_60.2-3ubuntu3.2_amd64.deb
    sudo ln -s /usr/lib/x86_64-linux-gnu/libdouble-conversion.so.3 /usr/lib/x86_64-linux-gnu/libdouble-conversion.so.1
    ```
4. Install SDK with
    ```sh
    sudo bash mtsdk_linux-x64_2022.0.sh
    sudo bash mfmsdk_linux-x64_2022.0.sh
    ```
5. Unpack mtmanager.tar.gz
6. Connect your IMU to PC
7. Identify the port it is conencted to, e.g. `/dev/ttyUSB0`
8. Add permission to read from the port
    ```sh
    chmod 666 /dev/ttyUSB0
    ```
9. Run:
    ```sh
    ./mtmanager
    ```
10. Identify the baudrate for your further work.


# Jetson Nano

Remove brltty (or maybe not)
[Link1](https://community.platformio.org/t/could-not-configure-port-25-inappropriate-ioctl-for-device-linux-mint/34878/5)
[Link2](https://lynxbee.com/solved-brltty-usb-com-port-gets-immediately-disconnected/)

Similar issue:
[Link](https://forums.developer.nvidia.com/t/jetson-nano-unable-to-communicate-with-serial-device/81928)

# Jetson Xavier

## Adding new sensor (serial port device)
### Getting vendor ID 
```bash
udevadm info -a -p $(udevadm info -q path -n /dev/ttyUSB0) | grep idVendor | head -1
```
Output:
```
ATTRS{idVendor}=="2639"
```
### Getting product ID
```bash
udevadm info -a -p $(udevadm info -q path -n /dev/ttyUSB0) | grep idProduct | head -1
```
Output:
```
ATTRS{idProduct}=="0013"
```

### Setting udev rules
Create file under `/etc/udev/rules.d` according to udev naming convention.<br>
> Files should be named xx-descriptive-name.rules, the xx should be chosen first according to the following sequence points:
>
> * < 60  most user rules; if you want to prevent an assignment being overriden by default rules, use the := operator. These cannot access persistent information such as that from vol_id; these cannot access persistent information such as that from vol_id
> * < 70  rules that run helpers such as vol_id to populate the udev db
> * < 90  rules that run other programs (often using information in the udev db)
> * \>=90  rules that should run last
    
So for example, create file `sudo nano /etc/udev/rules.d/55-your_sensor_name.rules` with the following content. Choose if it's ACM or USB interface.
```
KERNEL=="tty<ACM/USB>[0-9]*", SUBSYSTEM=="tty", ATTRS{idVendor}=="1546", ATTRS{idProduct}=="01a9", MODE="0666", SYMLINK="tty<your custom name>"
```

Reload the rules
```sh
sudo udevadm control --reload-rules && udevadm trigger
```
Disconnect and connect sensor again. Run `ls /dev` to notice changes.


### Install Xsense kernel modules
https://base.xsens.com/s/question/0D509000016hfSCCAY/mti300-interfacing-with-nvidia-tx1-platform-kernel-31096?language=en_US

Command
```sh
getconf LONG_BIT
```
Output:
```
64
```

Command
```
cd /usr/src/linux-headers-`uname -r`
sudo make modules_prepare
sudo git clone https://github.com/xsens/xsens_mt.git
cd xsens_mt
sudo make

```
