.DEFAULT_GOAL := help

.PHONY: help lint tests

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
GITHOOKS_DIR="$(ROOT_DIR)/.githooks/"

help:
	@cat $(MAKEFILE_LIST)

lint:
	@./Scripts/lint_code.sh

tests:
	@./Scripts/run_tests.sh

environment:
	git config core.hooksPath $(GITHOOKS_DIR)
