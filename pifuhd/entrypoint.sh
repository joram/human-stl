#!/usr/bin/env bash

#cd /openpose
#./build/examples/openpose/openpose.bin --image_dir /input --write_json /output --render_pose 2 --face --face_render 2 --hand --hand_render 2
#bash
export 'PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512'
python3 -m apps.simple_test
#python3 -m apps.simple_test -i /input -o /output
