#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"

#####################################################################

function 00_arrange () { : ; }
function 00_act () { : ; }
function 00_assert () { 
    cat ~/.kube/config
}
function 00_destroy () { : ; }
function 00_run {
	desc "The default config file is within the .kube directory found in your home folder (when using linux)"
	desc "The config file holds all the information that is required to connect to the Kubernetes cluster"
	desc "We'll start by viewing the contents of the file"
	hide "$(type 00_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 00_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 00_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 00_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "We can see that this is a yaml file, yaml files are used frequently within kubenetes"
	desc "There are 4 main sections that we're going to look at now:"
	desc " - clusters"
	desc " - users"
	desc " - contexts"
	desc " - current-context" "wait"
}


#####################################################################

function 01_arrange () { : ; }
function 01_act () { : ; }
function 01_assert () {
    < ~/.kube/config grep -A 4 "clusters:"
}
function 01_destroy () { : ; }

function 01_run {
	hide "$(type 01_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 01_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "Here is the cluster that we've recently setup"
	desc "We can see the Certificate Authority (CA), the CA is used to sign the certificates that are used to authenticate the user (you!)"
	desc "The server is the address to reach the API within your Kubernetes Control Plane"
	desc "Finally, the friendly name is a name that we can reference this cluster with, this is local to the config file and you can change it if you wanted" "wait"
}

#####################################################################

function 02_arrange () { : ; }
function 02_act () { : ; }
function 02_assert () {
    < ~/.kube/config grep -A 4 "users:"
}
function 02_destroy () { : ; }

function 02_run {
	desc "Kubernetes doensn't have a user database, but instead signs certificates to authenticate who you are"
	hide "$(type 02_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 02_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 02_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 02_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "In this example, the client.crt and the client.key are files on the local file system, you can also find certificates embedded within the config"
	desc "A friendly name of demo-cluster has been assigend to the user this is used to identify the user within the config file, not within Kubernetes" "wait"
}

#####################################################################

function 03_arrange () { : ; }
function 03_act () { : ; }
function 03_assert () {
    < ~/.kube/config grep -A 4 "contexts:"
}
function 03_destroy () { : ; }

function 03_run {
	desc "We have seen that the config file can have clusters and users, contexts are used to join them together"
	hide "$(type 03_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 03_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "In this instance, we're linking our cluster and user together, with the friendly name of demo-cluster" "wait"
}

#####################################################################

function 04_arrange () { : ; }
function 04_act () { : ; }
function 04_assert () {
    < ~/.kube/config grep "current-context:"
}
function 04_destroy () { : ; }

function 04_run {
	desc "A config file can have multple clusters, users and contexts."
	hide "$(type 03_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 03_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
	desc "current-cluster is used to identify which context is being used by default" "wait"
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
	elif [[ $cmd == "01_run" ]]; then
		01_run
	elif [[ $cmd == "02_run" ]]; then
		02_run
	elif [[ $cmd == "03_run" ]]; then
		03_run
	elif [[ $cmd == "04_run" ]]; then
		04_run
	elif [[ $cmd == "all" || $cmd == "" ]]; then
		00_run
		01_run
        02_run
        03_run
        04_run
	else
		error "Unable to find function $cmd"
	fi
}

main "$@"