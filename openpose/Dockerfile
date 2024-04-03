FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    cmake \
    git \
    wget \
    libatlas-base-dev \
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libhdf5-serial-dev \
    protobuf-compiler \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblmdb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libgtk2.0-dev \
    pkg-config \
    libopencv-dev

RUN apt install -y python3-pip python3 python3-opencv

# Clone OpenPose repository
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git /openpose

# Build OpenPose
WORKDIR /openpose
RUN mkdir build && cd build \
    && cmake .. \
        -DBUILD_PYTHON=ON \
        -DBUILD_UNITY=OFF \
        -DDOWNLOAD_BODY_25_MODEL=OFF \
        -DDOWNLOAD_BODY_MPI_MODEL=OFF \
        -DDOWNLOAD_HAND_MODEL=OFF \
        -DDOWNLOAD_FACE_MODEL=OFF \
        -DBUILD_EXAMPLES=ON \
        -DGPU_MODE=CPU_ONLY \
        -DCMAKE_BUILD_TYPE=Release \
    && make -j`nproc`
# Set the default command to run when container starts
ENV PYTHONPATH=/openpose/build/python/:$PYTHONPATH
# To ensure using CPU only
ENV CUDA_VISIBLE_DEVICES=""

CMD bash
ENTRYPOINT ["/entrypoint.sh"]
