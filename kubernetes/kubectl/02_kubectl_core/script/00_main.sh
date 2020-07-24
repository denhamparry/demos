#!/bin/bash

. "$(dirname ${BASH_SOURCE})/../../../../common.sh"

dir_path=$(dirname "$(realpath "$0")")

function setup {
    "$dir_path"/01_setup.sh
}

function setup-walkthrough {
	intro "Let's get started creating a cluster"
    setup
}

function run {
    "$dir_path"/02_kubectl.sh "$1"
}

function run-walkthrough {
	intro "View the help output for kubectl, these are the commands we'll be looking at today"
    "$dir_path"/02_kubectl.sh 00_kubectl
	intro "Print the client and server version information"
    "$dir_path"/02_kubectl.sh 01_kubectl_version
	intro "Display cluster info"
    "$dir_path"/02_kubectl.sh 02_kubectl_clusterinfo
	intro "Create a resource from stdin"
    "$dir_path"/02_kubectl.sh 03_kubectl_create_stdin
	intro "Create a resource from a file"
    "$dir_path"/02_kubectl.sh 04_kubectl_create_file
	intro "Create a resource using parameters"
    "$dir_path"/02_kubectl.sh 05_kubectl_create_parameters
	intro "Display one or many resources"
    "$dir_path"/02_kubectl.sh 06_kubectl_get
	intro "Print the supported API resources on the server"
    "$dir_path"/02_kubectl.sh 07_kubectl_apiresources
	intro "Print the supported API versions on the server, in the form of 'group/version'"
    "$dir_path"/02_kubectl.sh 08_kubectl_apiversions
	intro "Documentation of resources"
    "$dir_path"/02_kubectl.sh 09_kubectl_explain
	intro "Create a resource from stdin"
    "$dir_path"/02_kubectl.sh 10_kubectl_delete_stdin
	intro "Create a resource from a file"
    "$dir_path"/02_kubectl.sh 11_kubectl_delete_file
	intro "Create a resource using resource and name"
    "$dir_path"/02_kubectl.sh 12_kubectl_delete_resource_name
	intro "Create a resources using labels"
    "$dir_path"/02_kubectl.sh 13_kubectl_delete_label
	intro "Delete a resources in minimal time"
    "$dir_path"/02_kubectl.sh 14_kubectl_delete_minimal
	intro "Delete a resources immediately"
    "$dir_path"/02_kubectl.sh 15_kubectl_delete_dead
	intro "Delete all resources"
    "$dir_path"/02_kubectl.sh 16_kubectl_delete_all
}

function demo {
    docker run -it -v "$dir_path"/.asciinema/run_walkthrough.cast:/root/cast denhamparry/asciinema-client:latest
}

function cleanup {
    "$dir_path"/99_cleanup.sh
}

usage() {
	echo -e "\\n\\tKubectl core\\n"
	echo "Usage:"
	echo "  setup                                   - run setup scripts"
	echo "  setup-walkthrough                       - run setup scripts with explanation"
	echo "  run                                     - run the exercise scripts"
	echo "  run-walkthrough                         - run the exercise scripts with explanation"
    echo "  demo                                    - view the demo without having to run setup"
    echo "  cleanup                                 - reset enviroment"
}

main() {
	local cmd=$1

	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi

	if [[ $cmd == "setup" ]]; then
		setup
	elif [[ $cmd == "setup-walkthrough" ]]; then
		setup-walkthrough
	elif [[ $cmd == "run" ]]; then
		run "$2"
	elif [[ $cmd == "run-walkthrough" ]]; then
		run-walkthrough
	elif [[ $cmd == "demo" ]]; then
		demo
	elif [[ $cmd == "cleanup" ]]; then
		cleanup
	else
		usage
	fi
}

main "$@"