.ONESHELL:
SHELL=/bin/bash

cluster = kind-demo

all: setup certificates set-context
.PHONY: all

.PHONY: setup
setup: 
	@echo $(uname)
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.8.1/kind-$$(uname)-amd64
	chmod +x ./kind
	mv ./kind ~/bin

create:
	kind create cluster --name $(cluster)

list:
	kind get clusters

info:
	kubectl cluster-info --context kind-$(cluster)

delete:
	kind delete cluster --name $(cluster)
