project_name=requirements
project_version=0.0.1-dev

.PHONY: help build all

mirror := requirements.lock
help:
	    @echo "Makefile arguments:"
	    @echo ""
	    @echo "Makefile commands:"
	    @echo "mirror"
	    @echo "docker"
	    @echo "clean"

.DEFAULT_GOAL := all

clean:
		rm -rf mirror requirements.lock

docker: $(mirror)
	    DOCKER_BUILDKIT=1 docker build -t cltl/${project_name}:${project_version} .
$(mirror):
		pip download --requirement requirements.txt -d mirror \
			| grep Collecting | cut -f 2 -d ' ' > requirements.lock

all: docker