## Adding new sensor (serial port device)
### Getting vendor id

If GPS was connected after the IMU, than it should be named in `/dev` as `ttyUSB1`
```bash
udevadm info -a -p $(udevadm info -q path -n /dev/ttyUSB1) | grep idVendor | head -1
```
Output:
```
ATTRS{idVendor}=="0403"
```

### Getting product ID
```bash
udevadm info -a -p $(udevadm info -q path -n /dev/ttyUSB0) | grep idProduct | head -1
```
Output:
```
ATTRS{idProduct}=="6015"
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


## Wine
https://superuser.com/questions/1477796/making-usb-work-in-wine-4-0-ubuntu-19-04

## Configure F9P with ucenter

1. Connect (rememeber to give permission to port ttyUSB0 chmod 666)
2. follow https://drotek.gitbook.io/rtk-f9p-positioning-solutions/the-rtk-base/configuring-the-base-manually
3. or this https://s-taka.org/en/ubox-zed-f9p-configuration/
