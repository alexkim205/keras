DEB_CUDA_DOCKER=gw000/debian-cuda:9.1-7.0
GPU_DOCKER=alex-keras-gpu
GPU_DOCKER_V=0.0.1
CPU_DOCKER=alex-keras-cpu
CPU_DOCKER_V=0.0.1

# HELP
# This will output the help for each task
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container

#https://github.com/gw0/docker-debian-cuda
build-cuda: ## Build Debian + Cuda Docker
	docker build -t $(DEB_CUDA_DOCKER) -f dockerfiles/Dockerfile.deb-cuda .

build-gpu: build-cuda ## Build Python3 + TensorFlow + Jupyter + GPU Docker
	docker build -t $(GPU_DOCKER):$(GPU_DOCKER_V) -t $(GPU_DOCKER):latest -f dockerfiles/ .

build-cpu: ## Build Python3 + TensorFlow + Jupyter + CPU Docker
	docker build -t $(CPU_DOCKER):$(CPU_DOCKER_V) -t $(CPU_DOCKER):latest -f dockerfiles/ .
