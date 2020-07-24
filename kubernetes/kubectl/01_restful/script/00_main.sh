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
    "$dir_path"/02_curl.sh
}

function run-walkthrough {
	clear
	echo -e "\\n\\n"
	echo -e "TODO"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_curl.sh 00_view_config
	echo -e "\\n\\n"
	echo -e "TODO"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_curl.sh 01_curl_cluster
	echo -e "\\n\\n"
	echo -e "TODO"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_curl.sh 02_curl_pods
	echo -e "\\n\\n"
	echo -e "TODO"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_curl.sh 03_curl_deployment
	echo -e "\\n\\n"
	echo -e "TODO"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_curl.sh 04_curl_post
	echo -e "\\n\\n"
	echo -e "TODO"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
    "$dir_path"/02_curl.sh 05_curl_delete
	echo -e "\\n\\n"
	echo -e "TODO"
	read -r -n 1 -p "Press any key to continue..."
	echo -e "\\n\\n"
}

function demo {
    docker run -it -v "$dir_path"/.asciinema/run_walkthrough.cast:/root/cast denhamparry/asciinema-client:latest
}

function cleanup {
    "$dir_path"/99_cleanup.sh
}

usage() {
	echo -e "\\n\\tKubectl curl\\n"
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