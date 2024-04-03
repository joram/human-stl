#!/usr/bin/env bash

cd /openpose
./build/examples/openpose/openpose.bin \
  --image_dir /input \
  --write_json /output \
  --write_images /output \
  --display 0 \
  --render_pose 1
#  --face --face_render 1 \
#  --hand --hand_render 1
