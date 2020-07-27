#!/bin/bash

function 00_status {
    minikube status
}

main() {
	local cmd=$1

	if [[ $cmd == "00_status" ]]; then
		00_status
	else
		00_status
	fi
}

main "$@"