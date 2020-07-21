#!/bin/bash

function 00_minikube {
    minikube start -p demo-cluster
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