.ONESHELL:

SHELL=/bin/bash

cluster = rbac
location = /home/lewis/git/denhamparry/demos/kubernetes/rbac/step2/
demofolder = demo

all: 00_setup 99_clean
.PHONY: all

.PHONY: 00_setup
00_setup: 99_clean
	minikube start -p $(cluster)
	kubectl get nodes
	mkdir -p $(location)/$(demofolder)
	kubectl apply -f nginx.yaml
	echo "Wait for nginx pods..." && \
	sleep 10 && \
	kubectl get pods -n development

.PHONY: 01_build
01_build:
	eval $$(minikube -p $(cluster) docker-env) && \
	docker build -t endpoints/python:0.0.1 . && \
	echo -e "\nImage is now in Minikube Docker Daemon\n" && \
	docker image ls | grep "endpoints"

.PHONY: 02_deploy
02_deploy:
	kubectl apply -f endpoints-pod.yaml
	sleep 4 && \
	kubectl get pods -n development && \
	kubectl logs -n development endpoints-pod && \
	kubectl get sa -n development && \
	kubectl describe sa default -n development

.PHONY: 03_sa
03_sa:
	kubectl apply -f serviceaccount.yaml
	kubectl get sa -n development

.PHONY: 04_rbac
04_rbac:
	kubectl apply -f role-endpoints-list.yaml
	kubectl get roles -n development
	kubectl apply -f rolebinding-endpoints-list.yaml
	kubectl get rolebindings -n development

.PHONY: 05_sa_pod
05_sa_pod:
	kubectl delete -f endpoints-pod.yaml
	kubectl apply -f endpoints-pod-sa.yaml
	sleep 2
	kubectl get pods -n development
	kubectl logs -n development endpoints-pod
	
.PHONY: 99_clean
99_clean:
	rm -rf $(location)$(demofolder)
	minikube delete -p $(cluster)
