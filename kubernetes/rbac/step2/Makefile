SHELL=/bin/bash

cluster = rbac
location = /home/lewis/git/denhamparry/demos/kubernetes/rbac/step2/
demofolder = demo

all: 00_setup 97_sleep 01_demo 02_user 03_setup_rbac 98_sleep 04_test_application 99_clean
.PHONY: all

.PHONY: 00_setup
00_setup: 99_clean
	minikube start -p $(cluster)
	kubectl get nodes
	mkdir -p $(location)/$(demofolder)
	kubectl apply -f nginx.yaml

.PHONY: 01_demo
01_demo:
	python endpoints.py

.PHONY: 02_user
02_user:
	openssl genrsa -out $(location)$(demofolder)/employee.key 2048
	openssl req -new -key $(location)$(demofolder)/employee.key -out $(location)$(demofolder)/employee.csr -subj "/CN=employee/O=controlplane"
	openssl x509 -req -in $(location)$(demofolder)/employee.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out $(location)$(demofolder)/employee.crt -days 500
	kubectl config set-credentials employee --client-certificate=demo/employee.crt  --client-key=demo/employee.key
	kubectl config set-credentials employee --client-certificate=$(demofolder)/employee.crt  --client-key=$(demofolder)/employee.key
	kubectl config set-context employee-context --cluster=rbac --namespace=development --user=employee
	kubectl config view
	kubectl config use-context employee-context

.PHONY: 03_setup_rbac
03_setup_rbac:
	kubectl config use-context rbac
	kubectl create -f role-endpoints-list.yaml
	kubectl create -f rolebinding-endpoints-list.yaml

.PHONY: 04_test_application
04_test_application:
	kubectl config use-context employee-context
	python endpoints.py

.PHONY: 97_sleep
97_sleep:
	sleep 10

.PHONY: 98_sleep
98_sleep:
	sleep 10

.PHONY: 99_clean
99_clean:
	rm -rf $(location)$(demofolder)
	minikube delete -p $(cluster)
