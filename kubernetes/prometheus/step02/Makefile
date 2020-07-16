.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)/
demofolder = demo

.PHONY: all
all: 00_setup
.PHONY: demo
demo: demo_00_setup

.PHONY: 00_setup
00_setup:
	minikube start -p metrics

.PHONY: 01_setup_namespace
01_setup_metrics:
	kubectl create -f ./namespaces.yaml

.PHONY: 02_view_metrics
02_view_metrics:
	kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes" | jq .
	kubectl get --raw "/apis/metrics.k8s.io/v1beta1/pods" | jq .

.PHONY: 03_deploy_app
03_deploy_app:
	kubectl create -f ./podinfo/podinfo-svc.yaml,./podinfo/podinfo-dep.yaml

.PHONY: 04_review_metrics
04_review_metrics:
	kubectl get --raw "/apis/metrics.k8s.io/v1beta1/pods" | jq . | grep podinfo

.PHONY: 05_deploy_hpa
05_deploy_hpa:
	kubectl create -f ./podinfo/podinfo-hpa.yaml

.PHONY: 06_watch_pods
06_watch_pods:
	kubectl get pods -w

.PHONY: 07_what_happened
07_what_happened:
	kubectl describe hpa podinfo

.PHONY: 08_delete_hpa
08_delete_hpa:
	kubectl delete -f ./podinfo/podinfo-hpa.yaml
	kubectl get deployments podinfo

.PHONY: 99_cleanup
99_cleanup:
	kubectl delete -f ./podinfo/podinfo-hpa.yaml,./podinfo/podinfo-svc.yaml,./podinfo/podinfo-dep.yaml,./metrics-server
	kubectl get all --all-namespaces

.PHONY: demo_00_setup
demo_00_setup:
	docker run -it -v $(location).asciinema/00_setup.cast:/root/cast denhamparry/asciinema-client:latest

.PHONY: demo_01_start_application
demo_01_start_application:
	
	clear
	echo -e  ""
	echo -e  "************"
	echo -e  "Lets setup the metrics server"
	echo -e  "************"
	echo -e  ""
	read  -n 1 -p "Press any key to continue..."

	docker run -it -v $(location).asciinema/00_setup.cast:/root/cast denhamparry/asciinema-client:latest