FROM nvidia/cuda:12.3.2-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install requirements
RUN apt update
RUN apt install -y libgflags-dev
RUN apt install -y libgoogle-glog-dev
RUN apt install -y cmake-qt-gui libboost-all-dev libhdf5-dev libatlas-base-dev git
RUN apt install -y libopencv-dev build-essential libboost-system-dev libboost-thread-dev
RUN apt install -y libboost-program-options-dev libboost-test-dev libboost-filesystem-dev libhdf5-serial-dev
RUN apt install -y liblapack-dev libblas-dev build-essential libprotobuf-dev protobuf-compiler

# Get Source Code
WORKDIR /openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git /openpose
RUN git checkout v1.7.0
RUN git submodule update --init --recursive --remote
RUN bash ./scripts/ubuntu/install_cuda.sh


RUN apt install -y wget
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
RUN dpkg -i cuda-keyring_1.1-1_all.deb
RUN apt-get update
RUN apt-get -y install cudnn


# Build OpenPose
WORKDIR /openpose/build
#ADD ./openpose-docker-config/CMakeLists.txt /openpose/
ADD models /openpose/models

RUN cmake .. \
    -DBUILD_PYTHON=ON  \
    -DBUILD_CAFFE=ON  \
    -DBUILD_EXAMPLES=ON \
    -DBUILD_DOCS=OFF \
    -DBUILD_SHARED_LIBS=ON \
    -DGPU_MODE=CUDA \
    -DCUDA_ARCH="Manual" \
    -DCMAKE_BUILD_TYPE=Release
RUN make -j6

CMD ["/bin/bash"]

