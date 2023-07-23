#!/bin/bash

update-alternatives --remove-all gcc && update-alternatives --remove-all g++ &&\
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 30 &&\
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 30 &&\
update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30 &&\
update-alternatives --set cc /usr/bin/gcc &&\
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30 &&\
update-alternatives --set c++ /usr/bin/g++ &&\
update-alternatives --config gcc &&\
update-alternatives --config g++