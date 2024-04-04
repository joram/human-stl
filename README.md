# Human Photo to STL
this is based heavily on the works of two other projects:
- [openpose]()
- [pifuhd]()

## Openpose
Openpose is a library that can detect human poses in images and videos.
- all the code for openpose is in `./openpose`
- Everything has been containerized for cpu only (slower but better for portability)
### Testing
if you want to test the openpose container, you can run the following command:
```bash
docker compose up openpose
```
it will process all images in input dir, and write out the appropriate json files to the output dir.

## PIFuHD
PIFuHD is a library that can generate 3D models from 2D images, and the bones output of openpose.
- all the code for PIFuHD is in `./pifuhd`
- 

## Usage
Together, these two libraries can be used to generate 3D models from 2D images of humans.
