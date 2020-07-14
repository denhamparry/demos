.ONESHELL:

SHELL=/bin/bash

cluster = tools

all: 00_setup 99_clean
.PHONY: all

.PHONY: 00_setup
00_setup:
	minikube start -p $(cluster)
	kubectl get nodes

.PHONY: 01_permission_manager
01_permission_manager:
	kubectl apply -f permission-manager.yaml
	kubectl port-forward svc/permission-manager 4000 --namespace permission-manager &

.PHONY: 02_permission_manager_check
02_permission_manager_check:
	kubectl --kubeconfig demo/config get pods -n kube-system 

.PHONY: 03_rbac_tool
03_rbac_tool:
	rbac-tool viz

.PHONY: 99_clean
99_clean:
	kubectl config delete-context lewis-context
	kubectl config unset users.lewis
	minikube delete -p $(cluster)
