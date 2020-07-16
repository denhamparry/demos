.ONESHELL:

SHELL=/bin/bash

location = $(shell pwd)/
demofolder = demo

.PHONY: all
all: 00_setup 01_start_application 02_docker
.PHONY: demo
demo: demo_00_setup demo_01_start_application

.PHONY: 00_setup
00_setup:
	go get github.com/prometheus/client_golang/prometheus
	go get github.com/prometheus/client_golang/prometheus/promauto
	go get github.com/prometheus/client_golang/prometheus/promhttp

.PHONY: 01_start_application
01_start_application:

	echo -e  ""
	echo -e  "************"
	echo -e  "We are building a Go application to expose custom metrics"
	echo -e  "The application can be seen in main.go"
	echo -e  "Search for the metric myapp_processed_ops_total in the codebase"
	echo -e  "What do you expect to happen when we run the application?"
	echo -e  "************"
	echo -e  ""
	read  -n 1 -p "Press any key to continue..."

	go run main.go &
	
	echo -e  ""
	echo -e  "************"
	echo -e  "The application has started on localhost port 2112"
	echo -e  "Try opening your browser to http://localhost:2112/metrics to view the application metrics"
	echo -e  "************"
	echo -e  ""
	read  -n 1 -p "Press any key to continue..."

	curl http://localhost:2112/metrics
	curl http://localhost:2112/metrics | grep --color=always  "cpu"


	echo -e  ""
	echo -e  "************"
	echo -e  "We can also curl localhost to view the metrics"
	echo -e  "There are lots of default metrics being shared such as CPU, Memory, Network and Disk"
	echo -e  "Can you see the custom metric that we created? (myapp_processed_ops_total)"
	echo -e  "************"
	echo -e  ""
	read  -n 1 -p "Press any key to continue..."

	curl http://localhost:2112/metrics | grep --color=always  "myapp_processed_ops_total"

	echo -e  ""
	echo -e  "************"
	echo -e  "Using grep we can easily find the metric"
	echo -e  "Congratulations!  You can now share custom metrics via an endpoint"
	echo -e  "Why is this important?  What can we do with the metric?  Let's find out in the next section"
	echo -e  "But first, let's kill the app :)"
	echo -e  "************"
	echo -e  ""
	read  -n 1 -p "Press any key to continue..."

	killall main

.PHONY: 02_docker
02_docker:

	clear
	echo -e  -e "\n\n"
	
	echo -e  "************"
	echo -e  "We have built an application in Go serving custom metrics"
	echo -e  "To get this into a Kubernetes cluster, we're going to need to create an image"
	echo -e  "Lets look at the Dockerfile (Dockerfile)"
	echo -e  "************"
	echo -e "\n\n"
	read  -n 1 -p "Press any key to continue..."
	echo -e "\n\n"

	cat Dockerfile
	echo -e "\n\n"

	echo -e  "************"
	echo -e  "The image is based off GoLang 1.14, this will allow the application to be compiled in the container"
	echo -e  "We're setting the dependencies that we set at the start of the step within the image"
	echo -e  "The main.go file is copied into the image and it is built using go, lets try and build the image"
	echo -e  "************"
	echo -e  "\n\n"
	read  -n 1 -p "Press any key to continue..."
	echo -e  "\n\n"

	docker build -t denhamparry/metrics:0.0.1 -f Dockerfile .
	echo -e  "\n\n"

	echo -e  "************"
	echo -e  "We've built the image locally, but can we do better?"
	echo -e  "Let's look at the image size"
	echo -e  "************"
	echo -e  "\n\n"
	read  -n 1 -p "Press any key to continue..."
	echo -e  "\n\n"

	docker images | grep "0.0.1"
	echo -e  "\n\n"

	echo -e "************"
	echo -e "We can reduce the image size and potential security vunerabilities by using a multistage build"
	echo -e "A multistage build can copy the compiled application to a new image"
	echo -e "The new image doesn't require the tools needed to build the application, just to run it"
	echo -e "Have a look at the Dockerfile.multistage build to see this"
	echo -e "************"
	echo -e "\n\n"
	read  -n 1 -p "Press any key to continue..."
	echo -e  "\n\n"

	cat Dockerfile.multistage
	echo -e "\n\n"

	echo -e  "************"
	echo -e  "Lets build the multistage image and increment the version number"
	echo -e  "************"
	echo -e  "\n\n"
	read  -n 1 -p "Press any key to continue..."
	echo -e  "\n\n"

	docker build -t denhamparry/metrics:1.0.0 -f Dockerfile.multistage .
	echo -e  "\n\n"

	echo -e  "************"
	echo -e  "Now lets compare the image size"
	echo -e  "************"
	echo -e  "\n\n"
	read  -n 1 -p "Press any key to continue..."
	echo -e  "\n\n"

	docker images | grep "0.0.1"
	docker images | grep "1.0.0"
	echo -e  "\n\n"

	echo -e  "************"
	echo -e  "Lets test the application"
	echo -e  "************"
	echo -e  "\n\n"
	read  -n 1 -p "Press any key to continue..."
	echo -e  "\n\n"

	docker run -d --name metrics-demo -p 2112:2112 denhamparry/metrics:1.0.0
	curl localhost:2112/metrics
	echo -e  "\n\n"

	echo -e  "************"
	echo -e  "All looks good, lets stop and remove the container"
	echo -e  "************"
	echo -e  "\n\n"
	read  -n 1 -p "Press any key to continue..."
	echo -e  "\n\n"

	docker stop metrics-demo
	docker rm metrics-demo



.PHONY: demo_00_setup
demo_00_setup:
	docker run -it -v $(location).asciinema/00_setup.cast:/root/cast denhamparry/asciinema-client:latest

.PHONY: demo_01_start_application
demo_01_start_application:
	docker run -it -v $(location).asciinema/01_start_application.cast:/root/cast denhamparry/asciinema-client:latest