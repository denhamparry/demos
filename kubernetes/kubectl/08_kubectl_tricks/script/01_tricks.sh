#!/bin/bash

# shellcheck disable=SC1091
source "/common/base.sh"
source "/root/.bashrc"

#####################################################################

function 00_arrange () { : ; }
function 00_act () {
	echo "alias k=kubectl" >> ~/.bashrc
}
function 00_assert () {
	k get all --all-namespaces
}
function 00_destroy () { : ; }
function 00_alias_k {
	hide "$(type 00_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 00_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 00_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 00_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
}

#####################################################################

function 01_arrange () { : ; }
function 01_act () {
	echo "alias kdr='kubectl --dry-run=client -o yaml'" >> ~/.bashrc
}
function 01_assert () {
	kdr run nginx --image=nginx > rel_dir/nginx.yaml
}
function 01_destroy () { : ; }
function 01_alias_kdr {
	hide "$(type 01_arrange | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 01_act | sed '1,3d;$d' | sed 's/^ *//g')"
	show "$(type 01_assert | sed '1,3d;$d' | sed 's/^ *//g')"
	hide "$(type 01_destroy | sed '1,3d;$d' | sed 's/^ *//g')"
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

	if [[ $cmd == "00_alias_k" ]]; then
		00_alias_k
	elif [[ $cmd == "01_alias_kdr" ]]; then
		01_alias_kdr
	elif [[ $cmd == "all" || $cmd == "" ]]; then
		00_alias_k
		01_alias_kdr
	else
		error "Unable to find function $cmd"
	fi
}

main "$@"
