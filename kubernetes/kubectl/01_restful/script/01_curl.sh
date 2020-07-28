#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"

#####################################################################

function 00_arrange () { : ; }
function 00_act () { 
    cat ~/.kube/config
}
function 00_assert () { : ; }
function 00_destroy () { : ; }
function 00_run {
	hide "$(type 00_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 00_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 00_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 00_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 01_arrange () { : ; }
function 01_act () {
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key https://172.17.0.3:8443/api/ | jq .
}
function 01_assert () { : ; }
function 01_destroy () { : ; }
function 01_run {
	hide "$(type 01_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 01_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 02_arrange () { : ; }
function 02_act () {
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key https://172.17.0.3:8443/api/v1/namespaces/kube-system/pods | jq .
}
function 02_assert () { : ; }
function 02_destroy () { : ; }
function 02_run {
	hide "$(type 02_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 02_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 02_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 02_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 03_arrange () { : ; }
function 03_act () {
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key https://172.17.0.3:8443/apis/apps/v1/namespaces/kube-system/deployments/coredns | jq .
}
function 03_assert () { : ; }
function 03_destroy () { : ; }
function 03_run {
	hide "$(type 03_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 03_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 03_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 04_arrange () { : ; }
function 04_act () {
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key -X POST -H "Content-Type: application/json" -d @rel_dir/deployment.json https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments | jq .
}
function 04_assert () { 
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments/nginx-deployment | jq .
}
function 04_destroy () { 
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key -X DELETE https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments/nginx-deployment | jq .
}
function 04_run {
	hide "$(type 04_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 04_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 04_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 04_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 05_arrange () {
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key -X POST -H "Content-Type: application/json" -d @rel_dir/deployment.json https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments | jq .
}
function 05_act () {
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key -X DELETE https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments/nginx-deployment | jq .
}
function 05_assert () {
	curl --cacert /home/lewis/.minikube/ca.crt --cert /home/lewis/.minikube/profiles/demo-cluster/client.crt --key /home/lewis/.minikube/profiles/demo-cluster/client.key https://172.17.0.3:8443/apis/apps/v1/namespaces/default/deployments/nginx-deployment | jq .
}
function 05_destroy () { : ; }
function 05_run {
	hide "$(type 05_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 05_act | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 05_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 05_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
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
	elif [[ $cmd == "05_run" ]]; then
		05_run
	elif [[ $cmd == "all" || $cmd == "" ]]; then
		00_run
		01_run
        02_run
        03_run
        04_run
		05_run
	else
		error "Unable to find function $cmd"
	fi
}

main "$@"