.ONESHELL:

SHELL=/bin/bash

cluster = clusterrole
location = $(shell pwd)/
demofolder = demo

all: 00_setup 01_certificates 02_setup_rbac 03_test_lewis 99_clean
.PHONY: all

.PHONY: 00_setup
00_setup: 
	minikube start -p $(cluster)
	kubectl get nodes
	mkdir -p $(location)/$(demofolder)
	kubectl get secrets --all-namespaces

.PHONY: 01_certificates
01_certificates:
	openssl genrsa -out $(location)$(demofolder)/lewis.key 2048
	openssl req -new -key $(location)$(demofolder)/lewis.key -out $(location)$(demofolder)/lewis.csr -subj "/CN=lewis/O=trainer"
	openssl x509 -req -in $(location)$(demofolder)/lewis.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out $(location)$(demofolder)/lewis.crt -days 500
	kubectl config set-credentials lewis --client-certificate=demo/lewis.crt  --client-key=demo/lewis.key
	kubectl config set-credentials lewis --client-certificate=$(demofolder)/lewis.crt  --client-key=$(demofolder)/lewis.key
	kubectl config set-context lewis-context --cluster=$(cluster) --namespace=development --user=lewis
	kubectl config view

.PHONY: 02_setup_rbac
02_setup_rbac:
	kubectl create -f clusterrole-secret-reader.yaml
	kubectl create -f clusterrolebinding-secret-reader.yaml
	sleep 5

.PHONY: 03_test_lewis
03_test_lewis:
	kubectl --context=lewis-context get secrets --all-namespaces

.PHONY: 99_clean
99_clean:
	kubectl config delete-context lewis-context
	kubectl config unset users.lewis
	rm -rf $(location)$(demofolder)
	minikube delete -p $(cluster)