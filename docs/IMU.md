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


# Jetson

Remove brltty (or maybe not)
[Link1](https://community.platformio.org/t/could-not-configure-port-25-inappropriate-ioctl-for-device-linux-mint/34878/5)
[Link2](https://lynxbee.com/solved-brltty-usb-com-port-gets-immediately-disconnected/)

Similar issue:
[Link](https://forums.developer.nvidia.com/t/jetson-nano-unable-to-communicate-with-serial-device/81928)
