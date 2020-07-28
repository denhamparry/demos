.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)

.PHONY: all
all: run

.PHONY: docker
docker:
	docker run -it --rm \
	--privileged \
	--name demos \
	--network host \
	-v $(location):/demos \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ~/.kube/:/root/.kube/ \
	-v ~/.minikube:/home/lewis/.minikube \
	denhamparry/demos:0.0.1

.PHONY: install-auto
install-auto:
	$(location)/script/00_main.sh install-auto

.PHONY: install-walkthrough
install-walkthrough:
	$(location)/script/00_main.sh install-walkthrough

.PHONY: run-auto
run-auto:
	$(location)/script/00_main.sh run-auto
	
.PHONY: run-walkthrough
run-walkthrough:
	$(location)/script/00_main.sh run-walkthrough
	
.PHONY: demo
demo:
	$(location)/script/00_main.sh demo