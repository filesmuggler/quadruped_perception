FROM qp-base:20.04
# Minimal setup
RUN apt-get update \
 && apt-get install -y locales lsb-release openssh-server nano gnupg iputils-ping nmap
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
# TODO: add more xsense specific packages