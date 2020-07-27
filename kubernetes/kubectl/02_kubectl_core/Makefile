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
	-v $(location):/demo \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ~/.kube/:/root/.kube/ \
	-v ~/.minikube:/home/lewis/.minikube \
	denhamparry/demos:0.0.1

.PHONY: install
install:
	$(location)/script/00_main.sh install

.PHONY: install-walkthrough
install-walkthrough:
	$(location)/script/00_main.sh install-walkthrough

.PHONY: setup
setup:
	$(location)/script/00_main.sh setup

.PHONY: setup-walkthrough
setup-walkthrough:
	$(location)/script/00_main.sh setup-walkthrough

.PHONY: run
run:
	$(location)/script/00_main.sh run 
	
.PHONY: run-walkthrough
run-walkthrough:
	$(location)/script/00_main.sh run-walkthrough
	
.PHONY: demo
demo:
	$(location)/script/00_main.sh demo
	
.PHONY: cleanup
cleanup:
	$(location)/script/00_main.sh cleanup
