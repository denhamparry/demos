#!/bin/bash

function 00_move_config {
    mv ~/.kube/config ~/.kube/config."$(date --iso=seconds)"
}

function 01_minikube {
    minikube start -p demo-cluster
}


main() {
	00_move_config
	01_minikube
}

main() {
	local cmd=$1

	if [[ $cmd == "00_move_config" ]]; then
		00_move_config
	elif [[ $cmd == "01_minikube" ]]; then
		01_minikube
	else
		00_move_config
		01_minikube
	fi
}

main "$@"