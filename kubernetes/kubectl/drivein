#!/bin/bash

function drivein-linux () {
    docker run -it --rm \
	--privileged \
	--name drivein \
	--network host \
	-v "$1":/drivein \
	-v /home:/home \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ~/.kube/:/root/.kube/ \
	-v ~/.minikube:/home/lewis/.minikube \
	controlplane/drivein:0.0.1
}

function drivein-macos () {
    docker run -it --rm \
	--privileged \
	--name drivein \
	--network host \
	-v "$1":/drivein \
	-v /Users:/Users \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ~/.kube/:/root/.kube/ \
	-v ~/.minikube:/home/lewis/.minikube \
	controlplane/drivein:0.0.1
}

main() {
	local hostos=$2

	if [[ $hostos == "linux" ]]; then
		drivein-linux "$1"
	elif [[ $hostos == "macos" ]]; then
		drivein-macos "$1"
	else
		printf "%s not supported :(\\n" "$hostos"
	fi
}

main "$@"
