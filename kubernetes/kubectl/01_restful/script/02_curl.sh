#!/bin/bash

dir_path=$(dirname "$(realpath "$0")")

function 00_view_config {
    cat ~/.kube/config
}

function 01_curl_cluster {
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key https://172.17.0.3:8443/api/ | jq .
}

function 02_curl_pods {
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key https://172.17.0.3:8443/api/v1/namespaces/kube-system/pods | jq .
}

function 03_curl_deployment {
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key https://172.17.0.3:8443/apis/apps/v1/namespaces/kube-system/deployments/coredns | jq .
}

function 04_curl_post {
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key -X POST -H "Content-Type: application/json" -d @"$dir_path"/deployment.json https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments | jq .
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments/nginx-deployment | jq .
}

function 05_curl_delete {
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments/nginx-deployment
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments/nginx-deployment | jq .
}

main() {
	local cmd=$1

	if [[ $cmd == "00_view_config" ]]; then
		00_view_config
	elif [[ $cmd == "01_curl_cluster" ]]; then
		01_curl_cluster
	elif [[ $cmd == "02_curl_pods" ]]; then
		02_curl_pods
	elif [[ $cmd == "03_curl_deployment" ]]; then
		03_curl_deployment
	elif [[ $cmd == "03_curl_post" ]]; then
		03_curl_deployment
	elif [[ $cmd == "04_curl_post" ]]; then
		04_curl_post
	elif [[ $cmd == "05_curl_delete" ]]; then
		05_curl_delete
	else
		00_view_config
		01_fail_curl_cluster
		02_curl_pods
		03_curl_deployment
		04_curl_post
		05_curl_delete
	fi
}

main "$@"