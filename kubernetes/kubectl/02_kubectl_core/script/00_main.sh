#!/bin/bash

dir_path=$(dirname "$(realpath "$0")")

function setup {
    "$dir_path"/01_setup.sh
}

function setup-walkthorugh {
	clear
	echo -e "\\n\\n"
	echo -e "TODO"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/01_setup.sh
}

function run {
    "$dir_path"/02_kubectl.sh
}

function run-walkthrough {
	clear
	echo -e "\\n\\n"
	echo -e "TODO"
	echo -e "View the help output for kubectl, these are the commands we'll be looking at today"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_kubectl.sh 00_kubectl
	echo -e "\\n\\n"
	echo -e "Print the client and server version information"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_kubectl.sh 01_kubectl_version
	echo -e "\\n\\n"
	echo -e "Display cluster info"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_kubectl.sh 02_kubectl_clusterinfo
}

function demo {
    docker run -it -v "$dir_path"/.asciinema/run_walkthrough.cast:/root/cast denhamparry/asciinema-client:latest
}

function cleanup {
    "$dir_path"/99_cleanup.sh
}

usage() {
	echo -e "\\n\\tKubectl config\\n"
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