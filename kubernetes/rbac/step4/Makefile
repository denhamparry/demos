.ONESHELL:

SHELL=/bin/bash

cluster = deploy

all: 00_setup 01_build 02_deploy 03_redeploy 04_sa 05_rbac 06_sa_pod 99_clean
.PHONY: all

.PHONY: 00_setup
00_setup:
	minikube start -p $(cluster)
	kubectl get nodes
	mkdir -p $(location)/$(demofolder)
	kubectl apply -f nginx.yaml
	echo "Wait for nginx pods..." && \
	sleep 15 && \
	kubectl get pods -n development

.PHONY: 01_build
01_build:
	eval $$(minikube -p $(cluster) docker-env) && \
	docker build -t endpoints/python:0.0.1 -f Dockerfile . && \
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

.PHONY: 03_redeploy
03_redeploy:
	eval $$(minikube -p $(cluster) docker-env) && \
	kubectl delete -f endpoints-pod.yaml
	docker build -t endpoints/python:0.0.2 -f Dockerfile-sa . && \
	kubectl apply -f endpoints-pod.yaml

.PHONY: 04_sa
04_sa:
	kubectl apply -f serviceaccount.yaml
	kubectl get sa -n development

.PHONY: 05_rbac
05_rbac:
	kubectl apply -f role-endpoints-list.yaml
	kubectl get roles -n development
	kubectl apply -f rolebinding-endpoints-list.yaml
	kubectl get rolebindings -n development

.PHONY: 06_sa_pod
06_sa_pod:
	kubectl delete -f endpoints-pod.yaml
	kubectl apply -f endpoints-pod-sa.yaml
	sleep 2
	kubectl get pods -n development
	kubectl logs -n development endpoints-pod
	kubectl get secrets --all-namespaces | grep endpoint-service-account
	kubectl exec -it -n development endpoints-pod -- ls /var/run/secrets/kubernetes.io/serviceaccount 
	
.PHONY: 99_clean
99_clean:
	kubectl config delete-context lewis-context
	kubectl config unset users.lewis
	minikube delete -p $(cluster)
