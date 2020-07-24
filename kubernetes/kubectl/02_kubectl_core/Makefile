.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)

.PHONY: all
all: run

.PHONY: setup
setup:
	$(location)/script/00_main.sh setup

.PHONY: setup-walkthrough
setup-walkthrough:
	$(location)/script/00_main.sh setup-walkthrough

.PHONY: run
run:
	$(location)/script/00_main.sh run 
	
.PHONY: run-walkthrough
run-walkthrough:
	$(location)/script/00_main.sh run-walkthrough
	
.PHONY: demo
demo:
	$(location)/script/00_main.sh demo
	
.PHONY: cleanup
cleanup:
	$(location)/script/00_main.sh cleanup
