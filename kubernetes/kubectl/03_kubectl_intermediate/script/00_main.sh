#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"

dir_path=$(dirname "$(realpath "$0")")

function run {
	intro "Lets get started by installing the kubectl client"
    "$dir_path"/01_intermediate.sh 00_install_kubectl "$1"
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