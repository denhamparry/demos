.ONESHELL:

SHELL=/bin/bash

LOCATION = $(shell pwd)

#############################################

ifeq ($(OS),Windows_NT)
    HOSTOS=WIN
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        HOSTOS=linux
    endif
    ifeq ($(UNAME_S),Darwin)
        HOSTOS=macos
    endif
endif

#############################################

.PHONY: 00_kube_config
00_kube_config:
	@./drivein.sh "$(LOCATION)/00_kube_config" "$(HOSTOS)"

.PHONY: 00_kube_config_driveinema
00_kube_config_driveinema:
	@./driveinema.sh "$(LOCATION)/00_kube_config"

#############################################

.PHONY: 01_restful
01_restful:
	@./drivein.sh "$(LOCATION)/01_restful" "$(HOSTOS)"

.PHONY: 01_restful_driveinema
01_restful_driveinema:
	@./driveinema.sh "$(LOCATION)/01_restful"

#############################################

.PHONY: 02_kubectl_core
02_kubectl_core:
	@./drivein.sh "$(LOCATION)/02_kubectl_core" "$(HOSTOS)"

.PHONY: 02_kubectl_core_driveinema
02_kubectl_core_driveinema:
	@./driveinema.sh "$(LOCATION)/02_kubectl_core"

#############################################

.PHONY: 03_kubectl_intermediate
03_kubectl_intermediate:
	@./drivein.sh "$(LOCATION)/03_kubectl_intermediate" "$(HOSTOS)"

.PHONY: 03_kubectl_intermediate_driveinema
03_kubectl_intermediate_driveinema:
	@./driveinema.sh "$(LOCATION)/03_kubectl_intermediate"

#############################################

.PHONY: 08_kubectl_tricks
08_kubectl_tricks:
	@./drivein.sh "$(LOCATION)/08_kubectl_tricks" "$(HOSTOS)"

.PHONY: 08_kubectl_tricks_driveinema
08_kubectl_tricks_driveinema:
	@./driveinema.sh "$(LOCATION)/08_kubectl_tricks"

#############################################
