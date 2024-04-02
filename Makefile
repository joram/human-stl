build:
	docker build ./openpose -t joram87/openpose-cpu:latest
#	docker push joram87/openpose-cpu:latest
	docker build ./pifuhd -t joram87/pifuhd:latest

run: build
	docker run -it --rm -v ./openpose/models:/openpose/models -v ./input:/input -v ./output:/output joram87/openpose-cpu:latest
	cat ./input/human_keypoints.json
	echo ""

#	docker push joram87/pifuhd:latest


install-nvidia-container-runtime:
	curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
	curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
	sudo apt-get update
