SHELL = /bin/bash

project_root ?= $(realpath ..)
project_name ?= $(notdir $(realpath .))
project_version ?= $(shell cat version.txt)
project_chart ?= demo-app

.PHONY: run
run:
	# TODO move from docker desktop to kind to setup a local cluster
	# kind create cluster --name $(project_name)
	# docker images  --filter "reference=cltl/*" --format "{{.Repository}}:{{.Tag}}" | \
	# 	xargs -L 1 kind --name $(project_name) load docker-image
	kubectl cluster-info
	helm install $(project_name) $(project_root)/$(project_name)/$(project_chart)

.PHONY: kube-dashboard
kube-dashboard:
	$(info Log in token for kubernetes dashboard:)
	@kubectl -n kube-system describe secret \
		$(shell kubectl -n kube-system get secret | awk '/^admin-token-/{print $$1}') \
		| awk '$$1=="token:"{print $$2}' | head -n 1
	kubectl proxy

.PHONY: stop
stop:
	#kind delete cluster --name $(project_name)
	helm uninstall $(project_name)