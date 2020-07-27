#!/bin/bash

. "$(dirname ${BASH_SOURCE})/common.sh"

dir_path=$(dirname "$(realpath "$0")")

#####################################################################

function 00_arrange () { : ; }
function 00_act () { : ; }
function 00_assert () { 
	kubectl
}
function 00_destroy () { : ; }
function 00_kubectl {
	
	desc "Check the kubectl binary"
	hide "$(type 00_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 00_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 00_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 00_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 01_arrange () { : ; }
function 01_act () { : ; }
function 01_assert () { 
	kubectl version
}
function 01_destroy () { : ; }
function 01_kubectl_version {
	desc "Check the kubectl binary version and the kubernetes cluster version"
	hide "$(type 01_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 01_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 02_arrange () { : ; }
function 02_act () { : ; }
function 02_assert () { 
	kubectl cluster-info
}
function 02_destroy () { : ; }
function 02_kubectl_clusterinfo {
	desc "Cluster Information"
	hide "$(type 02_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 02_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 02_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 02_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 03_arrange () { : ; }
function 03_act {
	< rel_dir/deployment.yaml kubectl create -f -
}
function 03_assert () {
	x=0
	while [ "$x" != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		sleep 2
	done
}
function 03_destroy () {
	kubectl delete deployments nginx-deployment
}
function 03_kubectl_create_stdin {
	desc "Create from stdin"
	hide "$(type 03_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 03_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 04_arrange () { : ; }
function 04_act {
	kubectl create -f rel_dir/deployment.yaml
}
function 04_assert () {
	x=0
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
}
function 04_destroy () {
	kubectl delete -f rel_dir/deployment.yaml
}
function 04_kubectl_create_file () {
	desc "Create from file"
	hide "$(type 04_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 04_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 04_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 04_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
    
}

#####################################################################

function 05_arrange () { : ; }
function 05_act {
	kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods
}
function 05_assert () {
	kubectl get clusterroles | grep --color=auto pod-reader
}
function 05_destroy () {
	kubectl delete clusterrole pod-reader
}
function 05_kubectl_create_parameters {
	desc "Create using parameters"
	hide "$(type 05_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 05_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 05_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 05_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 06_arrange () {
	kubectl create -f rel_dir/get.yaml
}
function 06_act {
	x=0
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
}
function 06_assert () {
	kubectl get deployments
	kubectl get replicasets
	kubectl get pods
	kubectl get services
}
function 06_destroy () {
	kubectl delete -f rel_dir/get.yaml
}
function 06_kubectl_get {
	desc "Get resources"
	hide "$(type 06_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 06_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 06_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 06_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 07_arrange () { : ; }
function 07_act () { 
	kubectl api-resources
}
function 07_assert () {
	kubectl api-resources | grep --color=auto deployments
	kubectl api-resources | grep --color=auto replicasets
	kubectl api-resources | grep --color=auto pods
	kubectl api-resources | grep --color=auto services
}
function 07_destroy () { : ; }
function 07_kubectl_apiresources {
	desc "View api resources that are available"
	hide "$(type 07_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 07_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 07_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 07_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 08_arrange () { : ; }
function 08_act () { : ; }
function 08_assert () { 
	kubectl api-versions
}
function 08_destroy () { : ; }
function 08_kubectl_apiversions {
	desc "View api versions of resources"
	hide "$(type 08_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 08_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 08_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 08_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 09_arrange () { : ; }
function 09_act () { : ; }
function 09_assert () { 
	kubectl explain deployments
    kubectl explain deployments.spec
    kubectl explain deployments.spec.replicas
    kubectl explain pods
    kubectl explain pods.spec
 }
function 09_destroy () { : ; }
function 09_kubectl_explain {
	desc "Explain what the resources are"
	hide "$(type 09_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 09_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 09_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 09_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 10_arrange () { 
	kubectl create -f rel_dir/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
 }
function 10_act () {
	< rel_dir/nginx.yaml kubectl delete -f -
}
function 10_assert () {
	kubectl get pod pod-demo
}
function 10_destroy () { : ; }
function 10_kubectl_delete_stdin {
	desc "Delete using stdin"
	hide "$(type 10_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 10_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 10_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 10_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 11_arrange () {
	kubectl create -f rel_dir/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
}
function 11_act () { 
	kubectl delete -f rel_dir/nginx.yaml
}
function 11_assert () { : ; }
function 11_destroy () { : ; }
function 11_kubectl_delete_file {
	desc "Delete using a file"
	hide "$(type 11_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 11_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 11_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 11_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 12_arrange () {
	kubectl create -f rel_dir/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
}
function 12_act () {
	kubectl delete pod pod-demo
    kubectl delete service service-demo
}
function 12_assert () { : ; }
function 12_destroy () { : ; }
function 12_kubectl_delete_resource_name {
	desc "Delete using a resource and its name"
	hide "$(type 12_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 12_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 12_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 12_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 13_arrange () {
	kubectl create -f rel_dir/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
}
function 13_act () {
	kubectl delete pods,services -l app=nginx
}
function 13_assert () { : ; }
function 13_destroy () { : ; }
function 13_kubectl_delete_label {
	desc "Delete using labels"
	hide "$(type 13_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 13_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 13_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 13_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 14_arrange () {
	kubectl create -f rel_dir/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
}
function 14_act () {
	kubectl delete pod pod-demo --now
	kubectl delete service service-demo --now
}
function 14_assert () { : ; }
function 14_destroy () { : ; }
function 14_kubectl_delete_minimal {
	desc "Delete in minimal time"
	hide "$(type 14_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 14_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 14_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 14_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 15_arrange () {
	kubectl create -f rel_dir/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
}
function 15_act () {
	kubectl delete pod pod-demo --force
	kubectl delete service service-demo --force
}
function 15_assert () { : ; }
function 15_destroy () { : ; }
function 15_kubectl_delete_dead {
	desc "Force deletion"
	hide "$(type 15_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 15_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 15_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 15_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 16_arrange () { 
	kubectl create -f rel_dir/pods.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pods -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 7p)"
		kubectl get pods
		sleep 2
	done
}
function 16_act () {
	kubectl delete pods --all
}
function 16_assert () { : ; }
function 16_destroy () { : ; }
function 16_kubectl_delete_all {
	desc "Delete all resources"
	hide "$(type 16_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 16_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 16_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 16_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

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
	elif [[ $cmd == "13_kubectl_delete_label" ]]; then
		13_kubectl_delete_label
	elif [[ $cmd == "14_kubectl_delete_minimal" ]]; then
		14_kubectl_delete_minimal
	elif [[ $cmd == "15_kubectl_delete_dead" ]]; then
		15_kubectl_delete_dead
	elif [[ $cmd == "16_kubectl_delete_all" ]]; then
		16_kubectl_delete_all
	elif [[ $cmd == "all" || $cmd == "" ]]; then
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
	else
		error "Unable to find function $cmd"
	fi
}

main "$@"
