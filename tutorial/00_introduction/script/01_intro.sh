#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"

#####################################################################

function 00_arrange () {
	touch /driveindemo.txt
}
function 00_act () {
	echo "One way to write to a file." > /driveindemo.txt
}
function 00_assert () {
	ls /*driveindemo.txt*
	cat /driveindemo.txt
 }
function 00_destroy () { 
	rm /driveindemo.txt
}
function 00_run {
	desc "Welcome to drivein, helping you navigate new technologies on your own machine"
	show "$(type 00_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "When learning, its important to be able to interact with the technology, for example, if you press enter we will write to a file using echo"
	show "$(type 00_act | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "This is happening within a container, so you can think of this as a sandboxed enviroment running locally on your machine"
	show "$(type 00_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "But having a sandbox can only take you so far, we can interact with your local machine"
	hide "$(type 00_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

main() {
	local cmd=$1
	local version=$2
	
	if [[ -z "$cmd" ]]; then
		usage
		exit 1
	fi
	
	if [[ $version == "auto" ]]; then
		auto
	else
		demo
	fi

	if [[ $cmd == "00_run" ]]; then
		00_run
	elif [[ $cmd == "all" || $cmd == "" ]]; then
		00_run
	elif [[ $cmd == "all" || $cmd == "" ]]; then
		00_run
	else
		error "Unable to find function $cmd"
	fi
}

main "$@"