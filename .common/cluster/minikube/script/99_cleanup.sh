#!/bin/bash

function 00_delete_minikube {
    minikube delete -p demo-cluster
}


main() {
	00_delete_minikube
}

main() {
	local cmd=$1

	if [[ $cmd == "00_delete_minikube" ]]; then
		00_delete_minikube
	else
        00_delete_minikube
	fi
}

main "$@"