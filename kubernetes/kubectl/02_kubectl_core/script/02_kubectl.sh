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
	elif [[ $cmd == "99_kubectl_advanced" ]]; then
		99_kubectl_advanced
	else
		00_kubectl
		01_kubectl_version
		02_kubectl_clusterinfo
		03_kubectl_create_stdin
		04_kubectl_create_file
		99_kubectl_advanced
	fi
}

main "$@"

# Basic Commands (Beginner):
#   create        Create a resource from a file or from stdin.
#   expose        Take a replication controller, service, deployment or pod and expose it as a new Kubernetes Service
#   run           Run a particular image on the cluster
#   set           Set specific features on objects

# Basic Commands (Intermediate):
#   explain       Documentation of resources
#   get           Display one or many resources
#   edit          Edit a resource on the server
#   delete        Delete resources by filenames, stdin, resources and names, or by resources and label selector

# Deploy Commands:
#   rollout       Manage the rollout of a resource
#   scale         Set a new size for a Deployment, ReplicaSet or Replication Controller
#   autoscale     Auto-scale a Deployment, ReplicaSet, or ReplicationController

# Cluster Management Commands:
#   certificate   Modify certificate resources.
#   top           Display Resource (CPU/Memory/Storage) usage.
#   cordon        Mark node as unschedulable
#   uncordon      Mark node as schedulable
#   drain         Drain node in preparation for maintenance
#   taint         Update the taints on one or more nodes

# Troubleshooting and Debugging Commands:
#   describe      Show details of a specific resource or group of resources
#   logs          Print the logs for a container in a pod
#   attach        Attach to a running container
#   exec          Execute a command in a container
#   port-forward  Forward one or more local ports to a pod
#   proxy         Run a proxy to the Kubernetes API server
#   cp            Copy files and directories to and from containers.
#   auth          Inspect authorization

# Advanced Commands:
#   diff          Diff live version against would-be applied version
#   apply         Apply a configuration to a resource by filename or stdin
#   patch         Update field(s) of a resource using strategic merge patch
#   replace       Replace a resource by filename or stdin
#   wait          Experimental: Wait for a specific condition on one or many resources.
#   convert       Convert config files between different API versions
#   kustomize     Build a kustomization target from a directory or a remote url.

# Settings Commands:
#   label         Update the labels on a resource
#   annotate      Update the annotations on a resource
#   completion    Output shell completion code for the specified shell (bash or zsh)

# Other Commands:
#   alpha         Commands for features in alpha
#   api-resources Print the supported API resources on the server
#   api-versions  Print the supported API versions on the server, in the form of "group/version"
#   config        Modify kubeconfig files
#   plugin        Provides utilities for interacting with plugins.