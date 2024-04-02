build:
	docker build ./openpose -t joram87/openpose:latest
	docker push joram87/openpose:latest

run_pifuhd:
	docker build ./pifuhd -t joram87/pifuhd:latest
#	nvidia-smi --gpu-reset -i 0
	docker run -it --gpus all --rm -v ./input:/input -v ./output:/output joram87/pifuhd:latest

install-nvidia-container-runtime:
	curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
	curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
	sudo apt-get update
