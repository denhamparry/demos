.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)/
demofolder = demo

UNAME := $(shell uname)
PURPOSE:=metrics
SERVICE_NAME:=custom-metrics-apiserver
ALT_NAMES:="custom-metrics-apiserver.monitoring","custom-metrics-apiserver.monitoring.svc"
SECRET_FILE:=custom-metrics-api/cm-adapter-serving-certs.yaml

.PHONY: all
all: 00_setup
.PHONY: demo
demo: demo_00_setup

.PHONY: 00_setup
00_setup:
	minikube start -p metrics

.PHONY: 01_setup_namespace
01_setup_namespace:
	kubectl create -f ./namespaces.yaml

.PHONY: 02_setup_prometheus
02_setup_prometheus:
	kubectl create -f ./prometheus

.PHONY: 03_view_prometheus
03_view_prometheus:
	kubectl port-forward -n monitoring svc/prometheus 9090

.PHONY: 04_can_i_custom_metrics
04_can_i_custom_metrics:
	kubectl get --raw "/apis/custom.metrics.k8s.io/v1beta1" | jq .

.PHONY: 05_certs
05_certs: gensecret rmcerts

.PHONY: 06_setup_prometheus_adapter
06_setup_prometheus_adapter:
	kubectl create -f ./custom-metrics-api

.PHONY: 07_view_custom_metrics
07_view_custom_metrics:
	kubectl get --raw "/apis/custom.metrics.k8s.io/v1beta1" | jq .

.PHONY: 08_deploy_application
08_deploy_application:
	kubectl create -f ./podinfo/podinfo-svc.yaml,./podinfo/podinfo-dep.yaml

.PHONY: 09_view_application
09_view_application:
	kubectl port-forward -n default svc/podinfo 9898

.PHONY: 10_view_custom_metrics
10_view_custom_metrics:
	kubectl get --raw "/apis/custom.metrics.k8s.io/v1beta1/namespaces/default/pods/*/http_requests" | jq .

.PHONY: 11_create_custom_hpa
11_create_custom_hpa:
	kubectl create -f ./podinfo/podinfo-hpa-custom.yaml
	kubectl get hpa -w

.PHONY: 12_hey
12_hey:
	kubectl run --restart=Never -n default hey --image=ricoli/hey -- -n 10000 -q 5 -c 5 http://podinfo:9898/healthz &
	kubectl get hpa -w

.PHONY: 99_cleanup
99_cleanup:
	kubectl delete pod hey
	kubectl delete -f ./namespaces.yaml,./prometheus,./custom-metrics-api
	kubectl get all --all-namespaces
	rm custom-metrics-api/cm-adapter-serving-certs.yaml
	rm -rf output

.PHONY: gencerts
gencerts:
	@echo Generating TLS certs
	@docker pull cfssl/cfssl
	@mkdir -p output
	@touch output/apiserver.pem
	@touch output/apiserver-key.pem
	@openssl req -x509 -sha256 -new -nodes -days 365 -newkey rsa:2048 -keyout $(PURPOSE)-ca.key -out $(PURPOSE)-ca.crt -subj "/CN=ca"
	@echo '{"signing":{"default":{"expiry":"43800h","usages":["signing","key encipherment","'$(PURPOSE)'"]}}}' > "$(PURPOSE)-ca-config.json"
	@echo '{"CN":"'$(SERVICE_NAME)'","hosts":[$(ALT_NAMES)],"key":{"algo":"rsa","size":2048}}' | docker run  -v ${HOME}:${HOME} -v ${PWD}/metrics-ca.key:/go/src/github.com/cloudflare/cfssl/metrics-ca.key -v ${PWD}/metrics-ca.crt:/go/src/github.com/cloudflare/cfssl/metrics-ca.crt -v ${PWD}/metrics-ca-config.json:/go/src/github.com/cloudflare/cfssl/metrics-ca-config.json -i cfssl/cfssl gencert -ca=metrics-ca.crt -ca-key=metrics-ca.key -config=metrics-ca-config.json - | docker run --entrypoint=cfssljson -v ${HOME}:${HOME} -v ${PWD}/output:/go/src/github.com/cloudflare/cfssl/output -i cfssl/cfssl -bare output/apiserver

.PHONY: gensecret
gensecret: gencerts
	@echo Generating $(SECRET_FILE)
	@echo "apiVersion: v1" > $(SECRET_FILE)
	@echo "kind: Secret" >> $(SECRET_FILE)
	@echo "metadata:" >> $(SECRET_FILE)
	@echo " name: cm-adapter-serving-certs" >> $(SECRET_FILE)
	@echo " namespace: monitoring" >> $(SECRET_FILE)
	@echo "data:" >> $(SECRET_FILE)
ifeq ($(UNAME), Darwin)
	@echo " serving.crt: $$(cat output/apiserver.pem | base64)" >> $(SECRET_FILE)
	@echo " serving.key: $$(cat output/apiserver-key.pem | base64)" >> $(SECRET_FILE)
endif
ifeq ($(UNAME), Linux)
	@echo " serving.crt: $$(cat output/apiserver.pem | base64 -w 0)" >> $(SECRET_FILE)
	@echo " serving.key: $$(cat output/apiserver-key.pem | base64 -w 0)" >> $(SECRET_FILE)
endif

.PHONY: rmcerts
rmcerts:
	@rm -f apiserver-key.pem apiserver.csr apiserver.pem
	@rm -f metrics-ca-config.json metrics-ca.crt metrics-ca.key