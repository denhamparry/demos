.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)

.PHONY: all
all: build

.PHONY: build
build:
	docker build -t denhamparry/demos:0.0.1 .