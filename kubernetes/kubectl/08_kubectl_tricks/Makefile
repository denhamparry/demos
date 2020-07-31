.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)

.PHONY: all
all: run

.PHONY: run-auto
run-auto:
	source /root/.bashrc
	$(location)/script/00_main.sh run-auto
	
.PHONY: run-walkthrough
run-walkthrough:
	source /root/.bashrc
	$(location)/script/00_main.sh run-walkthrough