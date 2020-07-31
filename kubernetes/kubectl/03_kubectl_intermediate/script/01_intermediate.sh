#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"

#####################################################################

function 00_arrange () { : ; }
function 00_act () {
	curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
	chmod +x ./kubectl
	mv ./kubectl /usr/local/bin/kubectl
	kubectl version --client
}
function 00_assert () { 
	kubectl version --client
}
function 00_destroy () { : ; }
function 00_install_kubectl {
	hide "$(type 00_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "Download the kubectl binary install kubectl"
	desc "Kubectl is a binary and we need to set the permissions to execute it"
	desc "Move kubectl to a bin directory so the binary is accessible"
	desc "Check the kubectl binary"
	show "$(type 00_act | sed '1,3d;$d' | sed 's/^ *//g')"
	intro "Check to make sure it's been installed correctly"
	show "$(type 00_assert | sed '1,3d;$d' | sed 's/^ *//g')"
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

	if [[ $cmd == "00_install_kubectl" ]]; then
		00_install_kubectl
	elif [[ $cmd == "all" || $cmd == "" ]]; then
		00_install_kubectl
	else
		error "Unable to find function $cmd"
	fi
}

main "$@"
