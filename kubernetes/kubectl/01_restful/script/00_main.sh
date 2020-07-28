#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"

dir_path=$(dirname "$(realpath "$0")")

function install { : ;}

function install-auto {
    auto
	install
}

function install-walkthrough {
    demo
	install
}

function run {
	intro "kubernetes (with curl) - view config"
    "$dir_path"/01_curl.sh 00_run "$1"
	intro "kubernetes (with curl) - curl cluster"
    "$dir_path"/01_curl.sh 01_run "$1"
	intro "kubernetes (with curl) - curl pods"
    "$dir_path"/01_curl.sh 02_run "$1"
	intro "kubernetes (with curl) - curl deployment"
    "$dir_path"/01_curl.sh 03_run "$1"
	intro "kubernetes (with curl) - curl post"
    "$dir_path"/01_curl.sh 04_run "$1"
	intro "kubernetes (with curl) - curl delete"
    "$dir_path"/01_curl.sh 05_run "$1"
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

usage() {
	echo -e "\\n\\tKubectl core\\n"
	echo "Usage:"
	echo "  install-auto							- install required binaries for walkthrough"
	echo "  install-walkthrough						- install required binaries for walkthrough"
	echo "  run-auto								- run the exercise scripts"
	echo "  run-walkthrough                         - run the exercise scripts with explanation"
    echo "  demo                                    - view the demo without having to run setup"
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
	else
		usage
	fi
}

main "$@"