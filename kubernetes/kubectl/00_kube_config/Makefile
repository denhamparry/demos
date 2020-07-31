.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)

.PHONY: install-auto
install-auto:
	$(location)/script/00_main.sh install-auto

.PHONY: install-walkthrough
install-walkthrough:
	$(location)/script/00_main.sh install-walkthrough

.PHONY: run-auto
run-auto:
	$(location)/script/00_main.sh run-auto
	
.PHONY: run-walkthrough
run-walkthrough:
	$(location)/script/00_main.sh run-walkthrough