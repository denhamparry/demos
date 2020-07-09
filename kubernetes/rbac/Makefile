SHELL=/bin/bash

cluster = rbac
location = /home/lewis/git/denhamparry/demos/kubernetes/rbac/
demofolder = demo

all: setup certificates set-context
.PHONY: all

.PHONY: setup
setup: clean
	minikube start -p $(cluster)
	kubectl get nodes
	mkdir -p $(location)/$(demofolder)
	kubectl create namespace office

.PHONY: certificates
certificates:
	openssl genrsa -out $(location)$(demofolder)/employee.key 2048
	openssl req -new -key $(location)$(demofolder)/employee.key -out $(location)$(demofolder)/employee.csr -subj "/CN=employee/O=bitnami"
	openssl x509 -req -in $(location)$(demofolder)/employee.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out $(location)$(demofolder)/employee.crt -days 500

.PHONY: set-context
set-context:
	# kubectl config set-credentials employee --client-certificate=demo/employee.crt  --client-key=demo/employee.key
	kubectl config set-credentials employee --client-certificate=$(demofolder)/employee.crt  --client-key=$(demofolder)/employee.key
	kubectl config set-context employee-context --cluster=minikube --namespace=office --user=employee

.PHONY: test-employee
test-employee:
	kubectl --context=employee-context get pods

.PHONY: clean
clean:
	rm -rf $(location)$(demofolder)
	minikube delete -p $(cluster)