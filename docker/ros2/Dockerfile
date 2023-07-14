# Base image
FROM ubuntu:22.04
# Minimal setup
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install -y locales lsb-release openssh-server nano gnupg\
 iputils-ping nmap git build-essential ruby-dev gem install rake hoe
RUN dpkg-reconfigure locales && apt install -y software-properties-common\ 
 && add-apt-repository universe && apt install -y curl 
# Install ROS 2 Humble Hawksbill
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null'
RUN apt update && apt upgrade && apt install -y ros-humble-desktop
# Install other packages required further
RUN sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN  curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update && apt install python3-colcon-common-extensions
#RUN apt update && apt install ros-noetic-soem libnotify-dev doxygen ros-noetic-plotjuggler-ros plotjuggler#
# TODO: add plotjuggler and ethercat libs
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc