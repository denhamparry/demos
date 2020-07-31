#!/bin/bash

dir_path=$(dirname "$(realpath "$0")")

function setup {
    "$dir_path"/01_setup.sh
}


function run {
    "$dir_path"/02_config.sh
}

function demo {
    docker run -it -v "$dir_path"/.asciinema/run_walkthrough.cast:/root/cast controlplane/asciinema-client:latest
}

function cleanup {
    "$dir_path"/99_cleanup.sh
}

usage() {
	echo -e "\\n\\tKubectl config\\n"
	echo "Usage:"
	echo "  setup                                   - run setup scripts"
	echo "  run                                     - run the exercise scripts"
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
	elif [[ $cmd == "run" ]]; then
		run
	elif [[ $cmd == "demo" ]]; then
		demo
	elif [[ $cmd == "cleanup" ]]; then
		cleanup
	else
		usage
	fi
}

main "$@"