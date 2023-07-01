# quadruped_perception
Integration of F/T sensors, IMU and GNSS for Unitree Go1 Edu at PUT

# Build & Run

## (ROS1) Create workspace

```
cd catkin_ws/src
```

```
git clone --recursive https://github.com/orocos-toolchain/orocos_toolchain.git
```
```
git clone https://github.com/orocos/rtt_ros_integration.git
git clone https://github.com/orocos/soem.git
```

Create symbolic link for python3 
```
ln -s /usr/bin/python3.8 /usr/bin/python
```

# Reading sensors over EtherCAT



# ROS1 integration

# ROS2 integration


# Sensors
BFT-ROK-11-04-xx

Input
```
slaveinfo -map eno1
```
Output
```
root@mate:/catkin_ws# slaveinfo -map eno1
SOEM (Simple Open EtherCAT Master)
Slaveinfo
Starting slaveinfo
No socket connection on -map
Excecute as root
End program
root@mate:/catkin_ws# slaveinfo eno1
SOEM (Simple Open EtherCAT Master)
Slaveinfo
Starting slaveinfo
ec_init on eno1 succeeded.
1 slaves found and configured.
Calculated workcounter 3

Slave:1
 Name:BFT-ROK-11-04-xx
 Output size: 8bits
 Input size: 944bits
 State: 4
 Delay: 0[ns]
 Has DC: 1
 DCParentport:0
 Activeports:1.0.0.0
 Configured address: 1001
 Man: 0000096e ID: 00000000 Rev: 00000000
 SM0 A:1000 L: 128 F:00010026 Type:1
 SM1 A:1080 L: 128 F:00010022 Type:2
 SM2 A:1100 L:   1 F:00010024 Type:3
 SM3 A:1180 L: 118 F:00010020 Type:4
 FMMU0 Ls:00000000 Ll:   1 Lsb:0 Leb:7 Ps:1100 Psb:0 Ty:02 Act:01
 FMMU1 Ls:00000001 Ll: 118 Lsb:0 Leb:7 Ps:1180 Psb:0 Ty:01 Act:01
 FMMUfunc 0:1 1:2 2:3 3:0
 MBX length wr: 128 rd: 128 MBX protocols : 0c
 CoE details: 13 FoE details: 01 EoE details: 00 SoE details: 00
 Ebus current: 0[mA]
 only LRD/LWR:0
End slaveinfo, close socket
End program
root@mate:/catkin_ws# 
```

```
root@mate:/catkin_ws# slaveinfo eno1 -map
SOEM (Simple Open EtherCAT Master)
Slaveinfo
Starting slaveinfo
ec_init on eno1 succeeded.
4 slaves found and configured.
Calculated workcounter 6

Slave:1
 Name:GX-JC06(IN,X2,X3) Main device
 Output size: 0bits
 Input size: 0bits
 State: 4
 Delay: 0[ns]
 Has DC: 1
 DCParentport:0
 Activeports:1.1.1.1
 Configured address: 1001
 Man: 00000083 ID: 00000064 Rev: 00010001
 FMMUfunc 0:0 1:0 2:0 3:0
 MBX length wr: 0 rd: 0 MBX protocols : 00
 CoE details: 00 FoE details: 00 EoE details: 00 SoE details: 00
 Ebus current: 0[mA]
 only LRD/LWR:0
PDO mapping according to SII :

Slave:2
 Name:BFT-ROK-11-04-xx
 Output size: 8bits
 Input size: 944bits
 State: 4
 Delay: 800[ns]
 Has DC: 1
 DCParentport:3
 Activeports:1.0.0.0
 Configured address: 1002
 Man: 0000096e ID: 00000000 Rev: 00000000
 SM0 A:1000 L: 128 F:00010026 Type:1
 SM1 A:1080 L: 128 F:00010022 Type:2
 SM2 A:1100 L:   1 F:00010024 Type:3
 SM3 A:1180 L: 118 F:00010020 Type:4
 FMMU0 Ls:00000000 Ll:   1 Lsb:0 Leb:7 Ps:1100 Psb:0 Ty:02 Act:01
 FMMU1 Ls:00000002 Ll: 118 Lsb:0 Leb:7 Ps:1180 Psb:0 Ty:01 Act:01
 FMMUfunc 0:1 1:2 2:3 3:0
 MBX length wr: 128 rd: 128 MBX protocols : 0c
 CoE details: 13 FoE details: 01 EoE details: 00 SoE details: 00
 Ebus current: 0[mA]
 only LRD/LWR:0
PDO mapping according to CoE :
  SM2 outputs
     addr b   index: sub bitl data_type    name
  [0x0000.0] 0x7000:0x00 0x08 INTEGER8     Digital Output
  SM3 inputs
     addr b   index: sub bitl data_type    name
  [0x0002.0] 0x6000:0x01 0x08 UNSIGNED8    Status
  [0x0003.0] 0x6000:0x02 0x20 UNSIGNED32   Warnings Errors Fatals
  [0x0007.0] 0x6000:0x04 0x20 REAL32       Force x
  [0x000B.0] 0x6000:0x05 0x20 REAL32       Force y
  [0x000F.0] 0x6000:0x06 0x20 REAL32       Force z
  [0x0013.0] 0x6000:0x07 0x20 REAL32       Torque x
  [0x0017.0] 0x6000:0x08 0x20 REAL32       Torque y
  [0x001B.0] 0x6000:0x09 0x20 REAL32       Torque z
  [0x001F.0] 0x6000:0x0A 0x10 UNSIGNED16   Force Torque Saturated
  [0x0021.0] 0x6000:0x0B 0x20 REAL32       Acceleration x
  [0x0025.0] 0x6000:0x0C 0x20 REAL32       Acceleration y
  [0x0029.0] 0x6000:0x0D 0x20 REAL32       Acceleration z
  [0x002D.0] 0x6000:0x0E 0x08 UNSIGNED8    Acceleration Saturated
  [0x002E.0] 0x6000:0x0F 0x20 REAL32       Angular Rate x
  [0x0032.0] 0x6000:0x10 0x20 REAL32       Angular Rate y
  [0x0036.0] 0x6000:0x11 0x20 REAL32       Angular Rate z
  [0x003A.0] 0x6000:0x12 0x08 UNSIGNED8    Angular Rate Saturated
  [0x003B.0] 0x6000:0x13 0x20 REAL32       Temperature
  [0x003F.0] 0x6000:0x14 0x20 REAL32       Orientation Estimate x
  [0x0043.0] 0x6000:0x15 0x20 REAL32       Orientation Estimate y
  [0x0047.0] 0x6000:0x16 0x20 REAL32       Orientation Estimate z
  [0x004B.0] 0x6000:0x17 0x20 REAL32       Orientation Estimate w
  [0x004F.0] 0x6001:0x01 0x20 REAL32       Acceleration x
  [0x0053.0] 0x6001:0x02 0x20 REAL32       Acceleration y
  [0x0057.0] 0x6001:0x03 0x20 REAL32       Acceleration z
  [0x005B.0] 0x6001:0x04 0x20 REAL32       Angular Rate x
  [0x005F.0] 0x6001:0x05 0x20 REAL32       Angular Rate y
  [0x0063.0] 0x6001:0x06 0x20 REAL32       Angular Rate z
  [0x0067.0] 0x6001:0x07 0x20 REAL32       Orientation Estimate x
  [0x006B.0] 0x6001:0x08 0x20 REAL32       Orientation Estimate y
  [0x006F.0] 0x6001:0x09 0x20 REAL32       Orientation Estimate z
  [0x0073.0] 0x6001:0x0A 0x20 REAL32       Orientation Estimate w
  [0x0077.0] 0x6001:0x0B 0x08 UNSIGNED8    status

Slave:3
 Name:BFT-ROK-11-04-xx
 Output size: 8bits
 Input size: 944bits
 State: 4
 Delay: 2360[ns]
 Has DC: 1
 DCParentport:1
 Activeports:1.0.0.0
 Configured address: 1003
 Man: 0000096e ID: 00000000 Rev: 00000000
 SM0 A:1000 L: 128 F:00010026 Type:1
 SM1 A:1080 L: 128 F:00010022 Type:2
 SM2 A:1100 L:   1 F:00010024 Type:3
 SM3 A:1180 L: 118 F:00010020 Type:4
 FMMU0 Ls:00000001 Ll:   1 Lsb:0 Leb:7 Ps:1100 Psb:0 Ty:02 Act:01
 FMMU1 Ls:00000078 Ll: 118 Lsb:0 Leb:7 Ps:1180 Psb:0 Ty:01 Act:01
 FMMUfunc 0:1 1:2 2:3 3:0
 MBX length wr: 128 rd: 128 MBX protocols : 0c
 CoE details: 13 FoE details: 01 EoE details: 00 SoE details: 00
 Ebus current: 0[mA]
 only LRD/LWR:0
PDO mapping according to CoE :
  SM2 outputs
     addr b   index: sub bitl data_type    name
  [0x0001.0] 0x7000:0x00 0x08 INTEGER8     Digital Output
  SM3 inputs
     addr b   index: sub bitl data_type    name
  [0x0078.0] 0x6000:0x01 0x08 UNSIGNED8    Status
  [0x0079.0] 0x6000:0x02 0x20 UNSIGNED32   Warnings Errors Fatals
  [0x007D.0] 0x6000:0x04 0x20 REAL32       Force x
  [0x0081.0] 0x6000:0x05 0x20 REAL32       Force y
  [0x0085.0] 0x6000:0x06 0x20 REAL32       Force z
  [0x0089.0] 0x6000:0x07 0x20 REAL32       Torque x
  [0x008D.0] 0x6000:0x08 0x20 REAL32       Torque y
  [0x0091.0] 0x6000:0x09 0x20 REAL32       Torque z
  [0x0095.0] 0x6000:0x0A 0x10 UNSIGNED16   Force Torque Saturated
  [0x0097.0] 0x6000:0x0B 0x20 REAL32       Acceleration x
  [0x009B.0] 0x6000:0x0C 0x20 REAL32       Acceleration y
  [0x009F.0] 0x6000:0x0D 0x20 REAL32       Acceleration z
  [0x00A3.0] 0x6000:0x0E 0x08 UNSIGNED8    Acceleration Saturated
  [0x00A4.0] 0x6000:0x0F 0x20 REAL32       Angular Rate x
  [0x00A8.0] 0x6000:0x10 0x20 REAL32       Angular Rate y
  [0x00AC.0] 0x6000:0x11 0x20 REAL32       Angular Rate z
  [0x00B0.0] 0x6000:0x12 0x08 UNSIGNED8    Angular Rate Saturated
  [0x00B1.0] 0x6000:0x13 0x20 REAL32       Temperature
  [0x00B5.0] 0x6000:0x14 0x20 REAL32       Orientation Estimate x
  [0x00B9.0] 0x6000:0x15 0x20 REAL32       Orientation Estimate y
  [0x00BD.0] 0x6000:0x16 0x20 REAL32       Orientation Estimate z
  [0x00C1.0] 0x6000:0x17 0x20 REAL32       Orientation Estimate w
  [0x00C5.0] 0x6001:0x01 0x20 REAL32       Acceleration x
  [0x00C9.0] 0x6001:0x02 0x20 REAL32       Acceleration y
  [0x00CD.0] 0x6001:0x03 0x20 REAL32       Acceleration z
  [0x00D1.0] 0x6001:0x04 0x20 REAL32       Angular Rate x
  [0x00D5.0] 0x6001:0x05 0x20 REAL32       Angular Rate y
  [0x00D9.0] 0x6001:0x06 0x20 REAL32       Angular Rate z
  [0x00DD.0] 0x6001:0x07 0x20 REAL32       Orientation Estimate x
  [0x00E1.0] 0x6001:0x08 0x20 REAL32       Orientation Estimate y
  [0x00E5.0] 0x6001:0x09 0x20 REAL32       Orientation Estimate z
  [0x00E9.0] 0x6001:0x0A 0x20 REAL32       Orientation Estimate w
  [0x00ED.0] 0x6001:0x0B 0x08 UNSIGNED8    status

Slave:4
 Name:GX-JC06(X4,X5,X6) Sub-device
 Output size: 0bits
 Input size: 0bits
 State: 4
 Delay: 3260[ns]
 Has DC: 1
 DCParentport:2
 Activeports:1.0.0.0
 Configured address: 1004
 Man: 00000083 ID: 00000065 Rev: 00010001
 FMMUfunc 0:0 1:0 2:0 3:0
 MBX length wr: 0 rd: 0 MBX protocols : 00
 CoE details: 00 FoE details: 00 EoE details: 00 SoE details: 00
 Ebus current: 0[mA]
 only LRD/LWR:0
PDO mapping according to SII :
End slaveinfo, close socket
End program
root@mate:/catkin_ws# 
```

# useful links for debugging
- [ruby missing](https://answers.ros.org/question/282268/could-not-find-ruby-failed-to-process-package-orgen/)