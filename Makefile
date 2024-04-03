build:
	cd ./openpose; docker build . -t joram87/openpose:latest

build-cpu:
	cd ./openpose-cpu; docker build . -t joram87/openpose-cpu:latest

bash: build
	docker run -it --rm -v ./input:/input -v ./output:/output -v ./openpose/models:/openpose/models -v ./openpose/src:/my_src joram87/openpose:latest bash

bash-cpu: build-cpu
	docker run -it --rm -v ./input:/input -v ./output:/output -v ./openpose/models:/openpose/models -v ./openpose/src:/my_src joram87/openpose-cpu:latest bash

run: build
	docker run -it --rm --gpus all -v ./input:/input -v ./output:/output -v ./openpose/models:/openpose/models -v ./openpose/src:/my_src joram87/openpose:latest /my_src/entrypoint.sh

run-cpu: build-cpu
	docker run -it --rm -v ./input:/input -v ./output:/output -v ./openpose/models:/openpose/models -v ./openpose/src:/my_src joram87/openpose-cpu:latest /my_src/entrypoint.sh

