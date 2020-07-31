#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"

#####################################################################

function 00_arrange () { 
	rm /usr/local/bin/kubectl
}
function 00_act () {
	curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	mv ./kubectl /usr/local/bin/kubectl
}
function 00_assert () { 
	kubectl version --client
}
function 00_destroy () { : ; }
function 00_install_kubectl {
	hide "$(type 00_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "Download the kubectl binary install kubectl"
	desc "Kubectl is a binary and we need to set the permissions to execute it"
	desc "Move kubectl to a bin directory so the binary is accessible"
	desc "Check the kubectl binary"
	show "$(type 00_act | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "Check to make sure it's been installed correctly"
	show "$(type 00_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 00_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 01_arrange () { : ; }
function 01_act () { : ; }
function 01_assert () { 
	kubectl
}
function 01_destroy () { : ; }
function 01_kubectl {
	
	desc "Check the kubectl binary"
	hide "$(type 01_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 01_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 02_arrange () { : ; }
function 02_act () { : ; }
function 02_assert () { 
	kubectl version
}
function 02_destroy () { : ; }
function 02_kubectl_version {
	desc "Check the kubectl binary version and the kubernetes cluster version"
	hide "$(type 02_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 02_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 02_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 02_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 03_arrange () { : ; }
function 03_act () { : ; }
function 03_assert () { 
	kubectl cluster-info
}
function 03_destroy () { : ; }
function 03_kubectl_clusterinfo {
	desc "Cluster Information"
	hide "$(type 03_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 03_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 04_arrange () { : ; }
function 04_act {
	< rel_dir/deployment.yaml kubectl create -f -
}
function 04_assert () {
	x=0
	while [ "$x" != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		sleep 2
	done
}
function 04_destroy () {
	kubectl delete deployments nginx-deployment
}
function 04_kubectl_create_stdin {
	desc "Create from stdin"
	hide "$(type 04_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 04_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 04_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 04_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 05_arrange () { : ; }
function 05_act {
	kubectl create -f rel_dir/deployment.yaml
}
function 05_assert () {
	x=0
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
}
function 05_destroy () {
	kubectl delete -f rel_dir/deployment.yaml
}
function 05_kubectl_create_file () {
	desc "Create from file"
	hide "$(type 05_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 05_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 05_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 05_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 06_arrange () { : ; }
function 06_act {
	kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods
}
function 06_assert () {
	kubectl get clusterroles | grep --color=auto pod-reader
}
function 06_destroy () {
	kubectl delete clusterrole pod-reader
}
function 06_kubectl_create_parameters {
	desc "Create using parameters"
	hide "$(type 06_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 06_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 06_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 06_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 07_arrange () {
	kubectl create -f rel_dir/get.yaml
}
function 07_act {
	x=0
	while [ $x != "3" ]
	do
		x="$(kubectl get deployments nginx-deployment -o custom-columns=READY:.status.readyReplicas | sed -n 2p)"
		kubectl get deployments
		sleep 2
	done
}
function 07_assert () {
	kubectl get deployments
	kubectl get replicasets
	kubectl get pods
	kubectl get services
}
function 07_destroy () {
	kubectl delete -f rel_dir/get.yaml
}
function 07_kubectl_get {
	desc "Get resources"
	hide "$(type 07_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 07_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 07_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 07_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 08_arrange () { : ; }
function 08_act () { 
	kubectl api-resources
}
function 08_assert () {
	kubectl api-resources | grep --color=auto deployments
	kubectl api-resources | grep --color=auto replicasets
	kubectl api-resources | grep --color=auto pods
	kubectl api-resources | grep --color=auto services
}
function 08_destroy () { : ; }
function 08_kubectl_apiresources {
	desc "View api resources that are available"
	hide "$(type 08_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 08_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 08_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 08_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 09_arrange () { : ; }
function 09_act () { : ; }
function 09_assert () { 
	kubectl api-versions
}
function 09_destroy () { : ; }
function 09_kubectl_apiversions {
	desc "View api versions of resources"
	hide "$(type 09_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 09_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 09_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 09_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 10_arrange () { : ; }
function 10_act () { : ; }
function 10_assert () { 
	kubectl explain deployments
    kubectl explain deployments.spec
    kubectl explain deployments.spec.replicas
    kubectl explain pods
    kubectl explain pods.spec
 }
function 10_destroy () { : ; }
function 10_kubectl_explain {
	desc "Explain what the resources are"
	hide "$(type 10_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 10_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 10_assert | sed '1,3d;$d' | sed 's/^ *//g')"
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
	< rel_dir/nginx.yaml kubectl delete -f -
}
function 11_assert () {
	kubectl get pod pod-demo
}
function 11_destroy () { : ; }
function 11_kubectl_delete_stdin {
	desc "Delete using stdin"
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
	kubectl delete -f rel_dir/nginx.yaml
}
function 12_assert () { : ; }
function 12_destroy () { : ; }
function 12_kubectl_delete_file {
	desc "Delete using a file"
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
	kubectl delete pod pod-demo
    kubectl delete service service-demo
}
function 13_assert () { : ; }
function 13_destroy () { : ; }
function 13_kubectl_delete_resource_name {
	desc "Delete using a resource and its name"
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
	kubectl delete pods,services -l app=nginx
}
function 14_assert () { : ; }
function 14_destroy () { : ; }
function 14_kubectl_delete_label {
	desc "Delete using labels"
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
	kubectl delete pod pod-demo --now
	kubectl delete service service-demo --now
}
function 15_assert () { : ; }
function 15_destroy () { : ; }
function 15_kubectl_delete_minimal {
	desc "Delete in minimal time"
	hide "$(type 15_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 15_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 15_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 15_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 16_arrange () {
	kubectl create -f rel_dir/nginx.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pod pod-demo -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 2p)"
		kubectl get pod pod-demo
		sleep 2
	done
}
function 16_act () {
	kubectl delete pod pod-demo --force
	kubectl delete service service-demo --force
}
function 16_assert () { : ; }
function 16_destroy () { : ; }
function 16_kubectl_delete_dead {
	desc "Force deletion"
	hide "$(type 16_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 16_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 16_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 16_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 17_arrange () { 
	kubectl create -f rel_dir/pods.yaml
	x=0
	while [ $x != "true" ]
	do
		x="$(kubectl get pods -o custom-columns=READY:.status.containerStatuses[0].ready | sed -n 7p)"
		kubectl get pods
		sleep 2
	done
}
function 17_act () {
	kubectl delete pods --all
}
function 17_assert () { : ; }
function 17_destroy () { : ; }
function 17_kubectl_delete_all {
	desc "Delete all resources"
	hide "$(type 17_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 17_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 17_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 17_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

main() {
	local cmd=$1
	local version=$2
	
	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi
	
	if [[ $version == "auto" ]]; then
		auto
	else
		demo
	fi

	if [[ $cmd == "00_install_kubectl" ]]; then
		00_install_kubectl
	elif [[ $cmd == "01_kubectl" ]]; then
		01_kubectl
	elif [[ $cmd == "02_kubectl_version" ]]; then
		02_kubectl_version
	elif [[ $cmd == "03_kubectl_clusterinfo" ]]; then
		03_kubectl_clusterinfo
	elif [[ $cmd == "04_kubectl_create_stdin" ]]; then
		04_kubectl_create_stdin
	elif [[ $cmd == "05_kubectl_create_file" ]]; then
		05_kubectl_create_file
	elif [[ $cmd == "06_kubectl_create_parameters" ]]; then
		06_kubectl_create_parameters
	elif [[ $cmd == "07_kubectl_get" ]]; then
		07_kubectl_get
	elif [[ $cmd == "08_kubectl_apiresources" ]]; then
		08_kubectl_apiresources
	elif [[ $cmd == "09_kubectl_apiversions" ]]; then
		09_kubectl_apiversions
	elif [[ $cmd == "10_kubectl_explain" ]]; then
		10_kubectl_explain
	elif [[ $cmd == "11_kubectl_delete_stdin" ]]; then
		11_kubectl_delete_stdin
	elif [[ $cmd == "12_kubectl_delete_file" ]]; then
		12_kubectl_delete_file
	elif [[ $cmd == "13_kubectl_delete_resource_name" ]]; then
		13_kubectl_delete_resource_name
	elif [[ $cmd == "14_kubectl_delete_label" ]]; then
		14_kubectl_delete_label
	elif [[ $cmd == "15_kubectl_delete_minimal" ]]; then
		15_kubectl_delete_minimal
	elif [[ $cmd == "16_kubectl_delete_dead" ]]; then
		16_kubectl_delete_dead
	elif [[ $cmd == "17_kubectl_delete_all" ]]; then
		17_kubectl_delete_all
	elif [[ $cmd == "all" || $cmd == "" ]]; then
		00_install_kubectl
		01_kubectl
		02_kubectl_version
		03_kubectl_clusterinfo
		04_kubectl_create_stdin
		05_kubectl_create_file
		06_kubectl_create_parameters
		07_kubectl_get
		08_kubectl_apiresources
		09_kubectl_apiversions
		10_kubectl_explain
		11_kubectl_delete_stdin
		12_kubectl_delete_file
		13_kubectl_delete_resource_name
		14_kubectl_delete_label
		15_kubectl_delete_minimal
		16_kubectl_delete_dead
		17_kubectl_delete_all
	else
		error "Unable to find function $cmd"
	fi
}

main "$@"
