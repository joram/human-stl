#!/usr/bin/env bash

rm /data/output/*
./build/examples/openpose/openpose.bin \
  --image_dir /data/input/ \
  --write_images /data/output/ \
  --write_json /data/output/ \
  --display 0 \
