.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)/
demofolder = demo

.PHONY: 01_setup_namespace
01_setup_namespace:
	kubectl create -f ./namespaces.yaml

.PHONY: 02_setup_grafana
02_setup_grafana:
	kubectl apply --kustomize github.com/kubernetes/ingress-nginx/deploy/grafana/

.PHONY: 03_view_grafana
03_view_grafana:
	kubectl port-forward -n ingress-nginx svc/grafana 3000 &

.PHONY: 04_credentials
04_credentials:
	clear
	echo "Username: admin"
	echo "Password: admin"
	echo "Prometheus data source: http://prometheus.monitoring.svc:9090"

.PHONY: 99_cleanup
99_cleanup:
	killall kubectl