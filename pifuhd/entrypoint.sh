#!/usr/bin/env bash

echo "processing images into obj files"
python -m apps.simple_test -i /data/input -o /data/output

echo "cleaning up obj files"
python -m apps.clean_mesh -f /data/output