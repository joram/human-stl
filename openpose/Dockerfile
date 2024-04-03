FROM nvidia/cuda:12.3.2-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update

#get deps
RUN apt install -y --no-install-recommends \
python3-dev python3-pip python3-setuptools git g++ wget make libprotobuf-dev protobuf-compiler libopencv-dev \
libgoogle-glog-dev libboost-all-dev libhdf5-dev libatlas-base-dev

#for python api
#RUN pip3 install scikit-build
RUN pip3 install scikit-build numpy opencv-python

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
RUN dpkg -i cuda-keyring_1.1-1_all.deb
RUN apt-get update
RUN apt-get -y install cudnn
RUN apt install -y cmake
#get openpose
WORKDIR /openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git .

#build it
WORKDIR /openpose/build
RUN cmake -DBUILD_PYTHON=ON \
    -DDOWNLOAD_BODY_25_MODEL=OFF \
    -DDOWNLOAD_BODY_MPI_MODEL=OFF \
    -DDOWNLOAD_HAND_MODEL=OFF \
    -DDOWNLOAD_FACE_MODEL=OFF \
    -DBUILD_EXAMPLES=ON \
    -DBUILD_EXAMPLES=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DGPU_MODE=CUDA \
    -DCMAKE_BUILD_TYPE=Release \
    ..

# this is a hack. The openpose make tries to build a no-longer supported version of CUDA. This is a hack to fix it.
RUN sed -ie 's/set(KEPLER "35 37")/set(KEPLER "50")/g' /openpose/cmake/Cuda.cmake
RUN sed -ie 's/set(KEPLER "35 37")/set(KEPLER "50")/g' /openpose/3rdparty/caffe/cmake/Cuda.cmake

RUN make -j`nproc`
RUN make install

WORKDIR /openpose

#FROM ubuntu:22.04
#COPY --from=builder /openpose /openpose