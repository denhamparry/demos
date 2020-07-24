#!/bin/bash

. "$(dirname ${BASH_SOURCE})/../../../../common.sh"

run "minikube delete -p kubectl-core"