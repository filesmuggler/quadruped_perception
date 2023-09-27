# ROS1 (Noetic)

## User workspace setup

<figure>
   <p style='text-align: center;'>
      <img src="./imgs/dire_structure.jpg" width="200"><br>
      Directory tree structure, Source: <a href="">Own work</a>
   </p>
</figure>

Create tree of folders for your project:
```sh
mkdir qp
cd qp
mkdir -p catkin_ws/src && mkdir rosbags
cd catkin_ws/src
```
Clone the repository inside the `src` directory:
```sh
git clone -b noetic https://github.com/filesmuggler/quadruped_perception.git
```
Build the workspace

## Rokubi Mini F/T+IMU sensors

### Compatibility issue

Removing PDOs definitions for all types except A type broke the compatibility with older sensors like  BFT-ROK-11-40-xx type used in this project.

<figure>
   <p style='text-align: center;'>
      <img src="./imgs/dusk.jpeg"  width="100" height="100"><br>
      Foot image with rokubi mini F/T+IMU sensors. Source: <a href="">Own work</a> 
   </p>
</figure>

## Authors
- [Krzysztof Stężała](https://github.com/filesmuggler)