#!/bin/bash

dir_path=$(dirname "$(realpath "$0")")

function 00_kubectl {
    kubectl
}
function 01_kubectl_version {
    kubectl version
}

function 02_kubectl_clusterinfo {
    kubectl cluster-info
}

function 03_kubectl_create_stdin {
    kubectl create deployment nginx --image=nginx:1.19.1
	x=0
	while [ $x != "1" ]
	do
		x="$(kubectl get deployments nginx -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
	kubectl delete deployments nginx
}

function 04_kubectl_create_file {
    kubectl create -f "$dir_path"/deployment.yaml
	x=0
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
	kubectl delete -f "$dir_path"/deployment.yaml
}

function 05_kubectl_get {
    kubectl create -f "$dir_path"/get.yaml
	x=0
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
	kubectl get deployments
	kubectl get replicasets
	kubectl get pods
	kubectl get services
	kubectl delete -f "$dir_path"/deployment.yaml
}

function 06_kubectl_apiresources {
    kubectl api-resources
	kubectl api-resources | grep --color=auto deployments
	kubectl api-resources | grep --color=auto replicasets
	kubectl api-resources | grep --color=auto pods
	kubectl api-resources | grep --color=auto services
}

function 08_kubectl_explain {
    kubectl explain deployments
    kubectl explain deployments.spec
    kubectl explain deployments.spec.replicas
    kubectl explain pods
    kubectl explain pods.spec
}

function 99_kubectl_advanced {
    kubectl cluster-info dump >> "$dir_path"/clusterinfodump.txt
}

main() {
	local cmd=$1

	if [[ $cmd == "00_kubectl" ]]; then
		00_kubectl
	elif [[ $cmd == "01_kubectl_version" ]]; then
		01_kubectl_version
	elif [[ $cmd == "02_kubectl_clusterinfo" ]]; then
		02_kubectl_clusterinfo
	elif [[ $cmd == "03_kubectl_create_stdin" ]]; then
		03_kubectl_create_stdin
	elif [[ $cmd == "04_kubectl_create_file" ]]; then
		04_kubectl_create_file
	elif [[ $cmd == "05_kubectl_get" ]]; then
		05_kubectl_get
	elif [[ $cmd == "06_kubectl_apiresources" ]]; then
		06_kubectl_apiresources
	elif [[ $cmd == "99_kubectl_advanced" ]]; then
		99_kubectl_advanced
	else
		00_kubectl
		01_kubectl_version
		02_kubectl_clusterinfo
		03_kubectl_create_stdin
		04_kubectl_create_file
		05_kubectl_get
		06_kubectl_apiresources
		07_kubectl_apiversions
		08_kubectl_explain
		99_kubectl_advanced
	fi
}

main "$@"
