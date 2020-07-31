.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)

.PHONY: all
all: run

.PHONY: run-auto
run-auto:
	$(location)/script/00_main.sh run-auto
	
.PHONY: run-walkthrough
run-walkthrough:
	$(location)/script/00_main.sh run-walkthrough