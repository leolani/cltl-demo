SHELL = /bin/bash

project_root ?= $(realpath ..)
project_name = $(notdir $(realpath .))
project_version = $(shell cat version.txt)
project_repo ?= ${project_root}/cltl-requirements
project_mirror ?= ${project_root}/cltl-requirements/mirror

dependencies = $(addprefix $(project_root)/, \
		cltl-combot \
		cltl-demo-component)

.DEFAULT_GOAL := install


include $(project_root)/$(project_name)/*.mk
