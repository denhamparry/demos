.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)

.PHONY: all
all: run

.PHONY: setup
setup:
	$(location)/script/00_main.sh setup

.PHONY: run
run:
	$(location)/script/00_main.sh run
	
.PHONY: demo
demo:
	$(location)/script/00_main.sh demo
	
.PHONY: cleanup
cleanup:
	$(location)/script/00_main.sh cleanup
