FROM ubuntu:20.04
# MODIFIED from https://gist.github.com/cdcseacave/ef290eacefa44db67dadaed01a6fe319

# Get dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  cmake \
  build-essential \
  graphviz \
  git \
  coinor-libclp-dev \
  libceres-dev \
  libjpeg-dev \
  libpng-dev \
  libtiff-dev \
  libxi-dev \
  libxinerama-dev \
  libxcursor-dev \
  libxxf86vm-dev; \
  apt-get autoclean && apt-get clean

# Boost
RUN apt-get -y install libboost-iostreams-dev libboost-program-options-dev libboost-system-dev libboost-serialization-dev

# CGAL
RUN apt-get -y install libcgal-dev libcgal-qt5-dev

#GLFW3 (Optional)
RUN apt-get -y install freeglut3-dev libglew-dev libglfw3-dev

# Install COLMAP dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
  libboost-program-options-dev \
  libboost-filesystem-dev \
  libboost-graph-dev \
  libboost-regex-dev \
  libboost-system-dev \
  libboost-test-dev \
  libeigen3-dev \
  libsuitesparse-dev \
  libfreeimage-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  libglew-dev \
  qtbase5-dev \
  libqt5opengl5-dev \
  libflann-dev
RUN apt install -y libsqlite3-dev
RUN apt install -y libmetis-dev

# Build latest COLMAP
RUN git clone https://github.com/colmap/colmap.git; \
  mkdir comap_build && cd comap_build; \
  cmake . ../colmap -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="/opt"; \
  make -j4 && make install;

# OpenCV
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq libopencv-dev

# Build latest openvMVG
RUN git clone --recursive https://github.com/openMVG/openMVG.git; \
  mkdir openMVG_build && cd openMVG_build; \
  cmake -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX="/opt" \
    -DOpenMVG_BUILD_TESTS=OFF \
    -DOpenMVG_BUILD_EXAMPLES=OFF \
    -DOpenMVG_BUILD_DOC=OFF \
    -DOpenMVG_BUILD_OPENGL_EXAMPLES=ON \
    -DOpenMVG_USE_OPENCV=ON \
    -DOpenMVG_USE_OCVSIFT=OFF \
    -DCOINUTILS_INCLUDE_DIR_HINTS=/usr/include \
    -DCLP_INCLUDE_DIR_HINTS=/usr/include \
    -DOSI_INCLUDE_DIR_HINTS=/usr/include \
    -DEIGEN_INCLUDE_DIR_HINTS=/usr/include/eigen3 \
    ../openMVG/src; \
  make -j 4; \
  cp ../openMVG/src/openMVG/exif/sensor_width_database/sensor_width_camera_database.txt /opt/bin/;

# Eigen (Known issues with eigen 3.3.7 as of 12/10/2019, so using this tested branch/commit instead)
RUN git clone https://gitlab.com/libeigen/eigen --branch 3.4.0 ; \
  mkdir eigen_build && cd eigen_build; \
  cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX="/usr/local/include/eigen32" . ../eigen; \
  make && make install

# VCGLib
RUN git clone https://github.com/cdcseacave/VCG.git vcglib

RUN apt install -y python3 python3-pip

# Build latest openMVS
RUN git clone https://github.com/cdcseacave/openMVS.git; \
  mkdir openMVS_build && cd openMVS_build; \
  cmake . ../openMVS -DCMAKE_BUILD_TYPE=Release \
    -DVCG_ROOT=/vcglib \
    -DEIGEN3_INCLUDE_DIR=/usr/local/include/eigen32/include/eigen3;

RUN cd openMVS_build; make -j4
RUN cd openMVS_build; make install