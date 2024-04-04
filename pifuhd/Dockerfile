FROM joram87/openpose-cpu:latest as openpose

FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel

COPY --from=openpose /openpose /openpose
RUN apt install -y git wget python3-pip python3

WORKDIR /pifuhd
RUN git clone https://github.com/facebookresearch/pifuhd.git /pifuhd
ADD pifuhd.pt /pifuhd/checkpoints/pifuhd.pt
RUN apt install -y python3-pip python3
RUN pip3 install setuptools
RUN pip3 install matplotlib
RUN pip3 install torch
RUN pip3 install torchvision
RUN pip3 install Pillow                # PIL
RUN pip3 install scikit-image          #skimage
RUN pip3 install tqdm
RUN pip3 install opencv-python         # cv2
RUN pip3 install trimesh
RUN pip3 install PyOpenGL
RUN pip3 install ffmpeg

RUN find . -name '*.py' -exec sed -i -e 's/np.int/np.int32/g' {} \;
RUN find . -name '*.py' -exec sed -i -e 's/np.bool/bool/g' {} \;

ADD ./entrypoint.sh /pyfuhd/entrypoint.sh
ENTRYPOINT ["/pyfuhd/entrypoint.sh"]
