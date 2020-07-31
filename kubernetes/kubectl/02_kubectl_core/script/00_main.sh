#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"

dir_path=$(dirname "$(realpath "$0")")

function run {
	intro "Lets get started by installing the kubectl client"
    "$dir_path"/01_kubectl.sh 00_install_kubectl "$1"
	intro "View the help output for kubectl, these are the commands we'll be looking at today"
    "$dir_path"/01_kubectl.sh 01_kubectl "$1"
	intro "Print the client and server version information"
    "$dir_path"/01_kubectl.sh 02_kubectl_version "$1"
	intro "Display cluster info"
    "$dir_path"/01_kubectl.sh 03_kubectl_clusterinfo "$1"
	intro "Create a resource from stdin"
    "$dir_path"/01_kubectl.sh 04_kubectl_create_stdin "$1"
	intro "Create a resource from a file"
    "$dir_path"/01_kubectl.sh 05_kubectl_create_file "$1"
	intro "Create a resource using parameters"
    "$dir_path"/01_kubectl.sh 06_kubectl_create_parameters "$1"
	intro "Display one or many resources"
    "$dir_path"/01_kubectl.sh 07_kubectl_get "$1"
	intro "Print the supported API resources on the server"
    "$dir_path"/01_kubectl.sh 08_kubectl_apiresources "$1"
	intro "Print the supported API versions on the server, in the form of 'group/version'"
    "$dir_path"/01_kubectl.sh 09_kubectl_apiversions "$1"
	intro "Documentation of resources"
    "$dir_path"/01_kubectl.sh 10_kubectl_explain "$1"
	intro "Delete a resource from stdin"
    "$dir_path"/01_kubectl.sh 11_kubectl_delete_stdin "$1"
	intro "Delete a resource from a file"
    "$dir_path"/01_kubectl.sh 12_kubectl_delete_file "$1"
	intro "Delete a resource using resource and name"
    "$dir_path"/01_kubectl.sh 13_kubectl_delete_resource_name "$1"
	intro "Delete a resources using labels"
    "$dir_path"/01_kubectl.sh 14_kubectl_delete_label "$1"
	intro "Delete a resources in minimal time"
    "$dir_path"/01_kubectl.sh 15_kubectl_delete_minimal "$1"
	intro "Delete a resources immediately"
    "$dir_path"/01_kubectl.sh 16_kubectl_delete_dead "$1"
	intro "Delete all resources"
    "$dir_path"/01_kubectl.sh 17_kubectl_delete_all "$1"
}

function run-auto {
	run "auto"
}

function run-walkthrough {
	run "demo"
}

usage() {
	echo -e "\\n\\tKubectl core\\n"
	echo "Usage:"
	
	echo "  run-auto								- run the exercise scripts"
	echo "  run-walkthrough                         - run the exercise scripts with explanation"
}

main() {
	local cmd=$1

	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi

	if [[ $cmd == "run-auto" ]]; then
		run-auto "$2"
	elif [[ $cmd == "run-walkthrough" ]]; then
		run-walkthrough
	else
		usage
	fi
}

main "$@"