#!/bin/bash

main() {
	local folder=$1
	docker run --rm -ti -v "$folder"/script/.asciinema/:/casts/ controlplane/driveinema:0.0.1 play /casts/demo.cast
}

main "$@"
