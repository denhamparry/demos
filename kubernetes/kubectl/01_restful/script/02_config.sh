#!/bin/bash

function 00_view_config {
    cat ~/.kube/config
}

function 01_fail_curl_cluster {
    < ~/.kube/config grep -A 4 "clusters:"
}

main() {
	local cmd=$1

	if [[ $cmd == "00_view_config" ]]; then
		00_view_config
	elif [[ $cmd == "01_fail_curl_cluster" ]]; then
		01_fail_curl_cluster
	else
		00_view_config
		01_fail_curl_cluster
	fi
}

main "$@"