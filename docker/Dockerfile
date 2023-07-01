FROM ubuntu:20.04
# Minimal setup
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install -y locales lsb-release openssh-server nano gnupg\
 iputils-ping nmap git build-essential ruby-dev
RUN gem install rake hoe
RUN dpkg-reconfigure locales
# Install ROS Noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update \
 && apt-get install -y --no-install-recommends ros-noetic-desktop-full
RUN apt-get install -y --no-install-recommends python3-rosdep
RUN rosdep init \
 && rosdep fix-permissions \
 && rosdep update
RUN apt update && apt install ros-noetic-soem
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc