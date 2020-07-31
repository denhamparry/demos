.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)

.PHONY: all
all: run

.PHONY: docker
docker:
	docker run -it --rm \
	--privileged \
	--name drivein \
	--network host \
	-v $(location)/00_introduction:/drivein \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ~/.kube/:/root/.kube/ \
	-v ~/.minikube:/home/lewis/.minikube \
	controlplane/drivein:0.0.1

.PHONY: demo
demo:
	docker run --rm -ti -v $(location)/00_introduction/.driveinema/:/casts controlplane/driveinema:0.0.1 play /casts/demo.cast