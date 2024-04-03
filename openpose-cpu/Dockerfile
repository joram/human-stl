FROM python:3.12.2-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update

#get deps
RUN apt install -y --no-install-recommends \
python3-dev python3-pip python3-setuptools git g++ wget make libprotobuf-dev protobuf-compiler libopencv-dev \
libgoogle-glog-dev libboost-all-dev libhdf5-dev libatlas-base-dev

RUN apt install -y wget
RUN apt remove -y libprotobuf-dev

RUN wget http://ftp.de.debian.org/debian/pool/main/p/protobuf/libprotobuf23_3.12.4-1+deb11u1_amd64.deb
RUN apt install ./libprotobuf23_3.12.4-1+deb11u1_amd64.deb

RUN wget http://ftp.de.debian.org/debian/pool/main/p/protobuf/libprotobuf-lite23_3.12.4-1+deb11u1_amd64.deb
RUN apt install ./libprotobuf-lite23_3.12.4-1+deb11u1_amd64.deb

RUN wget http://ftp.us.debian.org/debian/pool/main/p/protobuf/libprotobuf-dev_3.12.4-1+deb11u1_amd64.deb
RUN apt install -y --allow-downgrades ./libprotobuf-dev_3.12.4-1+deb11u1_amd64.deb

RUN wget http://ftp.us.debian.org/debian/pool/main/p/protobuf/libprotoc23_3.12.4-1+deb11u1_amd64.deb
RUN apt install -y --allow-downgrades ./libprotoc23_3.12.4-1+deb11u1_amd64.deb

RUN wget http://ftp.us.debian.org/debian/pool/main/p/protobuf/protobuf-compiler_3.12.4-1+deb11u1_amd64.deb
RUN apt install -y --allow-downgrades ./protobuf-compiler_3.12.4-1+deb11u1_amd64.deb

#for python api
#RUN pip3 install scikit-build
RUN pip3 install scikit-build numpy opencv-python
RUN apt install -y cmake

#get openpose
WORKDIR /openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git .

#build it
WORKDIR /openpose/build
RUN cmake -D BUILD_PYTHON=OFF \
    -D DOWNLOAD_BODY_25_MODEL=OFF \
    -D DOWNLOAD_BODY_MPI_MODEL=OFF \
    -D DOWNLOAD_HAND_MODEL=OFF \
    -D DOWNLOAD_FACE_MODEL=OFF \
    -D BUILD_EXAMPLES=ON \
    -D BUILD_SHARED_LIBS=ON \
    -D GPU_MODE=CPU_ONLY \
    ..

# this is a hack. The openpose make tries to build a no-longer supported version of CUDA. This is a hack to fix it.
RUN sed -ie 's/set(KEPLER "35 37")/set(KEPLER "50")/g' /openpose/cmake/Cuda.cmake
RUN sed -ie 's/set(KEPLER "35 37")/set(KEPLER "50")/g' /openpose/3rdparty/caffe/cmake/Cuda.cmake

RUN make -j`nproc`
#RUN make install

WORKDIR /openpose

#FROM ubuntu:22.04
#COPY --from=builder /openpose /openpose

CMD bash