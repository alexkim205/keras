keras
==================

***alexkim205/keras*** is a minimal [*Docker*](http://www.docker.com/) image built from *Debian 9* (amd64) that has Python3, Keras, Jupyter, TensorFlow, and IPython.

Getting Started
====================

Pull the image from the [DockerHub repo](https://cloud.docker.com/swarm/alexkim205/repository/docker/alexkim205/keras/general).

```bash
# To pull the GPU image
docker pull alexkim205/keras:0.0.2-gpu

# To pull the CPU image
docker pull alexkim205/keras:0.0.2-cpu
```

Makefile Usage
==============

If you want to use the GPU, first `make build-cuda` then `make build-gpu`.

If you just want to use CPU, `make build-cpu`.

```bash
$ make help
help                           This help.
build-cuda                     Build Debian + Cuda Docker
build-gpu                      Build Python3 + TensorFlow + Jupyter + GPU Docker
build-cpu                      Build Python3 + TensorFlow + Jupyter + CPU Docker
```

Prerequisites to use GPU Docker
===============================

Host system requirements (eg. Debian 9 or similar Ubuntu):

- GPU card with CUDA Compute Capability 3.5 or higher
- *NVIDIA Kernel Driver* (`nvidia-kernel-dkms`)
- *CUDA Driver* library (`libcuda1`, same version as *NVIDIA Kernel Driver*)
- optionally `nvidia-smi`, `nvidia-opencl-icd`

To utilize your GPUs this Docker image needs access to your `/dev/nvidia*` devices and also the correct version of *CUDA Driver*.


Reference
=========

DockerHub - [gw000/keras](https://hub.docker.com/r/gw000/keras/)
GitHub (debian GPU image) - [gw0/docker-debian-cuda](https://github.com/gw0/docker-debian-cuda)
GitHub (keras) - [gw0/docker-keras](https://github.com/gw0/docker-keras)