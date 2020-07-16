.ONESHELL:

SHELL=/bin/bash

cluster = application
location = $(shell pwd)/
demofolder = demo

all: 00_setup 01_demo 02_user 03_setup_rbac 04_test_application 99_clean
.PHONY: all

.PHONY: 00_setup
00_setup:
	minikube start -p $(cluster)
	kubectl get nodes
	mkdir -p $(location)/$(demofolder)
	kubectl apply -f nginx.yaml
	kubectl get pods -n development

.PHONY: 01_demo
01_demo:
	python endpoints.py

.PHONY: 02_user
02_user:
	openssl genrsa -out $(location)$(demofolder)/lewis.key 2048
	openssl req -new -key $(location)$(demofolder)/lewis.key -out $(location)$(demofolder)/lewis.csr -subj "/CN=lewis/O=trainer"
	openssl x509 -req -in $(location)$(demofolder)/lewis.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out $(location)$(demofolder)/lewis.crt -days 500
	kubectl config set-credentials lewis --client-certificate=demo/lewis.crt  --client-key=demo/lewis.key
	kubectl config set-credentials lewis --client-certificate=$(demofolder)/lewis.crt  --client-key=$(demofolder)/lewis.key
	kubectl config set-context lewis-context --cluster=$(cluster) --namespace=development --user=lewis
	kubectl config view
	kubectl config use-context lewis-context

.PHONY: 03_setup_rbac
03_setup_rbac:
	kubectl config use-context $(cluster)
	kubectl create -f role-endpoints-list.yaml
	kubectl create -f rolebinding-endpoints-list.yaml
	sleep 5
	kubectl get roles -n development
	kubectl get rolebindings -n development

.PHONY: 04_test_application
04_test_application:
	kubectl config use-context lewis-context
	python endpoints.py

.PHONY: 99_clean
99_clean:
	kubectl config delete-context lewis-context
	kubectl config unset users.lewis
	rm -rf $(location)$(demofolder)
	minikube delete -p $(cluster)
