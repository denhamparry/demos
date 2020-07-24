#!/bin/bash

function 00_view_config {
    cat ~/.kube/config
}

function 01_view_clusters {
    < ~/.kube/config grep -A 4 "clusters:"
}

function 02_view_users {
    < ~/.kube/config grep -A 4 "users:"
}

function 03_view_contexts {
    < ~/.kube/config grep -A 4 "contexts:"
}

function 04_view_current_context {
    < ~/.kube/config grep "current-context:"
}

main() {
	local cmd=$1

	if [[ $cmd == "00_view_config" ]]; then
		00_view_config
	elif [[ $cmd == "01_view_clusters" ]]; then
		01_view_clusters
	elif [[ $cmd == "02_view_users" ]]; then
		02_view_users
	elif [[ $cmd == "03_view_contexts" ]]; then
		03_view_contexts
	elif [[ $cmd == "04_view_current_context" ]]; then
		04_view_current_context
	else
		00_view_config
		01_view_clusters
        02_view_users
        03_view_contexts
        04_view_current_context
	fi
}

main "$@"