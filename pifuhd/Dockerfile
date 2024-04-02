FROM cwaffles/openpose:latest as openpose


FROM cwaffles/openpose:latest
RUN apt install -y git wget python3-pip python3

WORKDIR /pifuhd
RUN git clone https://github.com/facebookresearch/pifuhd.git /pifuhd
ADD pifuhd.pt /pifuhd/checkpoints/pifuhd.pt
RUN apt install -y python3-pip python3
RUN pip3 install setuptools
RUN pip3 install matplotlib
RUN pip3 install -r /pifuhd/requirements.txt

RUN find . -name '*.py' -exec sed -i -e 's/np.int/np.int32/g' {} \;
RUN find . -name '*.py' -exec sed -i -e 's/np.bool/bool/g' {} \;

ADD ./entrypoint.sh /pyfuhd/entrypoint.sh
ENTRYPOINT ["/pyfuhd/entrypoint.sh"]
