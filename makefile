SHELL=/bin/bash

export project_root ?= $(realpath ..)
project_name = $(notdir $(realpath .))
project_version ?= "0.0.1-dev"

components = $(addprefix ${project_root}/, \
		cltl-combot \
		cltl-demo-component)


.DEFAULT_GOAL := build
target ?= install


dependencies = $(addsuffix /makefile.d, $(components))

.PHONY: depend
depend: $(dependencies)

$(dependencies):
	$(MAKE) --directory=$(dir $@) depend

include $(dependencies)


.PHONY: clean
clean:
	$(MAKE) target=clean

.PHONY: install
install:
	$(MAKE) target=install

.PHONY: docker
docker:
	$(MAKE) target=docker

.PHONY: build
build: $(components)

.PHONY: $(components)
$(components):
	$(MAKE) --directory=$@ $(target)


.PHONY: requirements-build
requirements-build: build


requirements-build: $(project_root)/cltl-requirements/leolani $(project_root)/cltl-requirements/mirror
	make --directory=$(project_root)/cltl-requirements build
