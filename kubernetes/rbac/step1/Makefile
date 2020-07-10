.ONESHELL:

SHELL=/bin/bash

cluster = roles
location = /home/lewis/git/denhamparry/demos/kubernetes/rbac/step1/
demofolder = demo

all: 00_setup 01_certificates 02_set_context 03_setup_rbac 04_deploy 05_test_lewis 99_clean
.PHONY: all

.PHONY: 00_setup
00_setup: 99_clean
	minikube start -p $(cluster)
	kubectl get nodes
	mkdir -p $(location)/$(demofolder)
	kubectl create namespace development

.PHONY: 01_certificates
01_certificates:
	openssl genrsa -out $(location)$(demofolder)/lewis.key 2048
	openssl req -new -key $(location)$(demofolder)/lewis.key -out $(location)$(demofolder)/lewis.csr -subj "/CN=lewis/O=trainer"
	openssl x509 -req -in $(location)$(demofolder)/lewis.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out $(location)$(demofolder)/lewis.crt -days 500

.PHONY: 02_set_context
02_set_context:
	kubectl config set-credentials lewis --client-certificate=demo/lewis.crt  --client-key=demo/lewis.key
	kubectl config set-credentials lewis --client-certificate=$(demofolder)/lewis.crt  --client-key=$(demofolder)/lewis.key
	kubectl config set-context lewis-context --cluster=$(cluster) --namespace=development --user=lewis
	kubectl config view

.PHONY: 03_setup_rbac
03_setup_rbac:
	kubectl create -f role-deployment-manager.yaml
	kubectl create -f rolebinding-deployment-manager.yaml
	sleep 10

.PHONY: 04_deploy
04_deploy:
	kubectl --context=lewis-context run --namespace development --image nginx:1.19.0 nginx

.PHONY: 05_test_lewis
05_test_lewis:
	kubectl --context=lewis-context get pods

.PHONY: 99_clean
99_clean:
	kubectl config delete-context lewis-context
	kubectl config unset users.lewis
	rm -rf $(location)$(demofolder)
	minikube delete -p $(cluster)