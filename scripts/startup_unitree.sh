#!/bin/bash

source ~/.bashrc
source /unitree_ws/devel/setup.bash
rosrun unitree_guide junior_ctrl &
roslaunch unitree_guide real.launch
