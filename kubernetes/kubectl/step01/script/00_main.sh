#!/bin/bash

dir_path=$(dirname "$(realpath "$0")")

function setup {
    "$dir_path"/01_setup.sh
}

function setup-walkthorugh {
    echo -e "\\n\\t00_setup\\n"
    echo "- Move any existing kube config file to set clean setup"
	echo "- Create a minikube cluster called Kubectl"
    echo -e "\\n"
	echo "We're going to rename the existing config (if it exists)"
	echo "This will keep the exercises clearer going forward"
	echo "By the end of the exercises, you will have a better understanding of the config file"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/01_setup.sh 00_move_config
    echo -e "\\n"
	echo "For this exercise, we're going to use a minikube cluster"
	echo "Minikube creates a single node cluster on your machine"
	echo "When creating the cluster, a new config file will be created, that we'll look at during the next step"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/01_setup.sh 01_minikube
}

function run {
    "$dir_path"/02_config.sh
}

function run-walkthorugh {
    "$dir_path"/02_config.sh
}

function demo {
    docker run -it -v "$dir_path"/.asciinema/00_setup.cast:/root/cast denhamparry/asciinema-client:latest
}

function cleanup {
    "$dir_path"/99_cleanup.sh
}

usage() {
	echo -e "00_setup.sh\\n\\tKubectl 00_setup\\n"
	echo "Usage:"
	echo "  setup                                   - run setup scripts"
	echo "  setup-walkthrough                       - run setup scripts"
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
		run
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