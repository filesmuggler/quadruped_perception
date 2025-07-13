FROM qp-base:20.04
# Minimal setup
RUN apt-get update \
 && apt-get install -y locales lsb-release openssh-server nano gnupg iputils-ping nmap
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
# TODO: add more unitree specific packages
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN apt update && apt-get install software-properties-common ros-noetic-move-base-msgs liblcm-dev -y
RUN apt update && apt install -y ros-noetic-soem
# update gcc and g++ to version 10
#RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt update && apt install -y gcc-10 g++-10 