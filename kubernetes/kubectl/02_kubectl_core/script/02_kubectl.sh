#!/bin/bash

source ../../../common.sh

dir_path=$(dirname "$(realpath "$0")")

function 00_kubectl {
	demoheader "Kubectl"
    demofocus "kubectl"
	demoend
}

function 01_kubectl_version {
	demoheader "Version"
    demofocus "kubectl version"
	demoend
}

function 02_kubectl_clusterinfo {
	demoheader "Cluster Information"
    demofocus "kubectl cluster-info"
	demoend
}

function 03_kubectl_create_stdin {
	demoheader "Create from stdin"
    demofocus "cat $dir_path/deployment.yaml | kubectl create -f -"
	x="0"
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
	kubectl delete deployments nginx-deployment
	demoend
}

function 04_kubectl_create_file {
	demoheader "Create from file"
    demofocus "kubectl create -f $dir_path/deployment.yaml"
	x=0
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
	kubectl delete -f "$dir_path"/deployment.yaml
	demoend
}

function 05_kubectl_create_parameters {
	demoheader "Create using parameters"
    demofocus "kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods"
	kubectl get clusterroles | grep --color=auto pod-reader
	kubectl delete clusterrole pod-reader
	demoend
}

function 06_kubectl_get {
	demoheader "Get resources"
    kubectl create -f "$dir_path"/get.yaml
	x=0
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
    demofocus "kubectl get deployments"
    demofocus "kubectl get replicasets"
    demofocus "kubectl get pods"
    demofocus "kubectl get services"
	kubectl delete -f "$dir_path"/get.yaml
	demoend
}

function 07_kubectl_apiresources {
	demoheader "View api resources that are available"
    demofocus "kubectl api-resources"
	kubectl api-resources | grep --color=auto deployments
	kubectl api-resources | grep --color=auto replicasets
	kubectl api-resources | grep --color=auto pods
	kubectl api-resources | grep --color=auto services
	demoend
}

function 08_kubectl_apiversions {
	demoheader "View api versions of resources"
    demofocus "kubectl api-versions"
	demoend
}

function 09_kubectl_explain {
	demoheader "Explain what the resources are"
    demofocus "kubectl explain deployments"
    demofocus "kubectl explain deployments.spec"
    demofocus "kubectl explain deployments.spec.replicas"
    demofocus "kubectl explain pods"
    demofocus "kubectl explain pods.spec"
}

function 10_kubectl_delete_stdin {
	demoheader "Delete using stdin"
	kubectl create -f "$dir_path"/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
    demofocus "cat $dir_path/nginx.yaml | kubectl delete -f -"
	demoend
}

function 11_kubectl_delete_file {
	demoheader "Delete using a file"
	kubectl create -f "$dir_path"/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
    demofocus "kubectl delete -f $dir_path/nginx.yaml"
	demoend
}

function 12_kubectl_delete_resource_name {
	demoheader "Delete using a resource and its name"
	kubectl create -f "$dir_path"/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
    demofocus "kubectl delete pod pod-demo"
    demofocus "kubectl delete service service-demo"
	demoend
}

function 13_kubectl_delete_label {
	demoheader "Delete using labels"
	kubectl create -f "$dir_path"/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
    demofocus "kubectl delete pods,services -l app=nginx"
	demoend
}

function 14_kubectl_delete_minimal {
	demoheader "Delete in minimal time"
	kubectl create -f "$dir_path"/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
    demofocus "kubectl delete pod pod-demo --now"
    demofocus "kubectl delete service service-demo --now"
	demoend
}

function 15_kubectl_delete_dead {
	demoheader "Force deletion"
	kubectl create -f "$dir_path"/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
    demofocus "kubectl delete pod pod-demo --force"
    demofocus "kubectl delete service service-demo --force"
	demoend
}

function 16_kubectl_delete_all {
	demoheader "Delete all resources"
	kubectl create -f "$dir_path"/pods.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pods -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 7p)"
		kubectl get pods
		sleep 2
	done
    demofocus "kubectl delete pods --all"
	demoend
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
	elif [[ $cmd == "05_kubectl_create_parameters" ]]; then
		05_kubectl_create_parameters
	elif [[ $cmd == "06_kubectl_get" ]]; then
		06_kubectl_get
	elif [[ $cmd == "07_kubectl_apiresources" ]]; then
		07_kubectl_apiresources
	elif [[ $cmd == "08_kubectl_apiversions" ]]; then
		08_kubectl_apiversions
	elif [[ $cmd == "09_kubectl_explain" ]]; then
		09_kubectl_explain
	elif [[ $cmd == "10_kubectl_delete_stdin" ]]; then
		10_kubectl_delete_stdin
	elif [[ $cmd == "11_kubectl_delete_file" ]]; then
		11_kubectl_delete_file
	elif [[ $cmd == "12_kubectl_delete_resource_name" ]]; then
		12_kubectl_delete_resource_name
	elif [[ $cmd == "13_kubectl_delete_minimal" ]]; then
		13_kubectl_delete_minimal
	elif [[ $cmd == "14_kubectl_delete_minimal" ]]; then
		14_kubectl_delete_minimal
	elif [[ $cmd == "15_kubectl_delete_dead" ]]; then
		15_kubectl_delete_dead
	elif [[ $cmd == "16_kubectl_delete_all" ]]; then
		16_kubectl_delete_all
	else
		00_kubectl
		01_kubectl_version
		02_kubectl_clusterinfo
		03_kubectl_create_stdin
		04_kubectl_create_file
		05_kubectl_create_parameters
		06_kubectl_get
		07_kubectl_apiresources
		08_kubectl_apiversions
		09_kubectl_explain
		10_kubectl_delete_stdin
		11_kubectl_delete_file
		12_kubectl_delete_resource_name
		13_kubectl_delete_label
		14_kubectl_delete_minimal
		15_kubectl_delete_dead
		16_kubectl_delete_all
	fi
}

main "$@"
