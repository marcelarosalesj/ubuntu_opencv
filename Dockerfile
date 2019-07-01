FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt -y update
RUN apt -y upgrade
RUN apt install -y build-essential cmake unzip pkg-config \
    libjpeg-dev libpng-dev libtiff-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev \
    libgtk-3-dev \
    libatlas-base-dev gfortran \
    python3-dev \
    python3-pip \
    wget \
    git \
    libtbb2 libtbb-dev libdc1394-22-dev \
    qt5-default libvtk6-dev zlib1g-dev

RUN pip3 install numpy
RUN pip3 install --upgrade pip

RUN cd ~/ &&\
    pwd &&\
    wget -O opencv.zip https://github.com/opencv/opencv/archive/4.0.0.zip &&\
    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.0.0.zip &&\
    unzip opencv.zip &&\
    unzip opencv_contrib.zip &&\
    mv opencv-4.0.0 opencv &&\
    mv opencv_contrib-4.0.0 opencv_contrib &&\
    cd opencv &&\
    mkdir build &&\
    cd build &&\
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D INSTALL_C_EXAMPLES=OFF \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON .. && \
    make -j4 && \
    make install &&\
    ldconfig


