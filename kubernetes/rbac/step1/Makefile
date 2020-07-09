SHELL=/bin/bash

cluster = rbac
location = /home/lewis/git/denhamparry/demos/kubernetes/rbac/step1/
demofolder = demo

all: 00_setup 01_certificates 02_set_context 03_setup_rbac 04_deploy 05_test_employee 99_clean
.PHONY: all

.PHONY: 00_setup
00_setup: 99_clean
	minikube start -p $(cluster)
	kubectl get nodes
	mkdir -p $(location)/$(demofolder)
	kubectl create namespace office

.PHONY: 01_certificates
01_certificates:
	openssl genrsa -out $(location)$(demofolder)/employee.key 2048
	openssl req -new -key $(location)$(demofolder)/employee.key -out $(location)$(demofolder)/employee.csr -subj "/CN=employee/O=bitnami"
	openssl x509 -req -in $(location)$(demofolder)/employee.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out $(location)$(demofolder)/employee.crt -days 500

.PHONY: 02_set_context
02_set_context:
	kubectl config set-credentials employee --client-certificate=demo/employee.crt  --client-key=demo/employee.key
	kubectl config set-credentials employee --client-certificate=$(demofolder)/employee.crt  --client-key=$(demofolder)/employee.key
	kubectl config set-context employee-context --cluster=rbac --namespace=office --user=employee
	kubectl config view

.PHONY: 03_setup_rbac
03_setup_rbac:
	kubectl create -f role-deployment-manager.yaml
	kubectl create -f rolebinding-deployment-manager.yaml
	sleep 5

.PHONY: 04_deploy
04_deploy:
	sleep 10
	kubectl --context=employee-context run --namespace office --image bitnami/dokuwiki mydokuwiki

.PHONY: 05_test_employee
05_test_employee:
	kubectl --context=employee-context get pods

.PHONY: 99_clean
99_clean:
	rm -rf $(location)$(demofolder)
	minikube delete -p $(cluster)