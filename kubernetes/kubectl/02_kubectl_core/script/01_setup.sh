#!/bin/bash

. "$(dirname ${BASH_SOURCE})/common.sh"

function 00_minikube {
    show "minikube start -p kubectl-core"
}


main() {
	00_minikube
}

main() {
	local cmd=$1

	if [[ $cmd == "00_minikube" ]]; then
		00_minikube
	else
		00_minikube
	fi
}

main "$@"