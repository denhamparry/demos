#!/bin/bash

. "/common/base.sh"

dir_path=$(dirname "$(realpath "$0")")

function install {
	intro "Lets install kubectl"
	show "curl -LO 'https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl'"
	intro "Kubectl is a binary and we need to set the permissions to execute it"
	show "chmod +x ./kubectl"
	intro "Move kubectl to a bin directory so the binary is accessible"
	show "mv ./kubectl /usr/local/bin/kubectl"
	intro "Check to make sure it's been installed correctly"
	show "kubectl version --client"
}

function install-auto {
    auto
	install
}

function install-walkthrough {
    demo
	install
}

function run {
	intro "View the help output for kubectl, these are the commands we'll be looking at today"
    "$dir_path"/02_kubectl.sh 00_kubectl "$1"
	intro "Print the client and server version information"
    "$dir_path"/02_kubectl.sh 01_kubectl_version "$1"
	intro "Display cluster info"
    "$dir_path"/02_kubectl.sh 02_kubectl_clusterinfo "$1"
	intro "Create a resource from stdin"
    "$dir_path"/02_kubectl.sh 03_kubectl_create_stdin "$1"
	intro "Create a resource from a file"
    "$dir_path"/02_kubectl.sh 04_kubectl_create_file "$1"
	intro "Create a resource using parameters"
    "$dir_path"/02_kubectl.sh 05_kubectl_create_parameters "$1"
	intro "Display one or many resources"
    "$dir_path"/02_kubectl.sh 06_kubectl_get "$1"
	intro "Print the supported API resources on the server"
    "$dir_path"/02_kubectl.sh 07_kubectl_apiresources "$1"
	intro "Print the supported API versions on the server, in the form of 'group/version'"
    "$dir_path"/02_kubectl.sh 08_kubectl_apiversions "$1"
	intro "Documentation of resources"
    "$dir_path"/02_kubectl.sh 09_kubectl_explain "$1"
	intro "Create a resource from stdin"
    "$dir_path"/02_kubectl.sh 10_kubectl_delete_stdin "$1"
	intro "Create a resource from a file"
    "$dir_path"/02_kubectl.sh 11_kubectl_delete_file "$1"
	intro "Create a resource using resource and name"
    "$dir_path"/02_kubectl.sh 12_kubectl_delete_resource_name "$1"
	intro "Create a resources using labels"
    "$dir_path"/02_kubectl.sh 13_kubectl_delete_label "$1"
	intro "Delete a resources in minimal time"
    "$dir_path"/02_kubectl.sh 14_kubectl_delete_minimal "$1"
	intro "Delete a resources immediately"
    "$dir_path"/02_kubectl.sh 15_kubectl_delete_dead "$1"
	intro "Delete all resources"
    "$dir_path"/02_kubectl.sh 16_kubectl_delete_all "$1"
}

function run-auto {
	run "auto"
}

function run-walkthrough {
	run "demo"
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
	echo "  install-auto						- install required binaries for walkthrough"
	echo "  install-walkthrough						- install required binaries for walkthrough"
	echo "  run-auto							- run the exercise scripts"
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

	if [[ $cmd == "install-auto" ]]; then
		install-auto
	elif [[ $cmd == "install-walkthrough" ]]; then
		install-walkthrough
	elif [[ $cmd == "run-auto" ]]; then
		run-auto "$2"
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