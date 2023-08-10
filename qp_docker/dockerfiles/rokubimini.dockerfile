# Base image
FROM qp-base:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
# Install other packages required further
RUN apt update && apt install -y ruby-dev ros-noetic-soem libnotify-dev doxygen ros-noetic-plotjuggler-ros
RUN gem install rake hoe
