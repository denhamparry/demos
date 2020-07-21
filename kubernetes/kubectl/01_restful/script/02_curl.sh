#!/bin/bash

function 00_view_config {
    cat ~/.kube/config
}

function 01_curl_cluster {
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key https://172.17.0.3:8443/api/
}

function 02_curl_pods {
	curl --cacert ~/.minikube/ca.crt --cert ~/.minikube/profiles/curl-cluster/client.crt --key ~/.minikube/profiles/curl-cluster/client.key https://172.17.0.3:8443/api/v1/namespaces/kube-system/pods
}

main() {
	local cmd=$1

	if [[ $cmd == "00_view_config" ]]; then
		00_view_config
	elif [[ $cmd == "01_curl_cluster" ]]; then
		01_curl_cluster
	elif [[ $cmd == "02_curl_pods" ]]; then
		02_curl_pods
	else
		00_view_config
		01_fail_curl_cluster
		02_curl_pods
	fi
}

main "$@"