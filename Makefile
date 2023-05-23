.DEFAULT_GOAL := help

.PHONY: help lint tests environment

GITHOOKS_DIR := ".githooks"

help:
	@cat $(MAKEFILE_LIST)

lint:
	@./Scripts/lint_code.sh --strict

tests:
	@./Scripts/run_tests.sh

environment:
	git config core.hooksPath $(GITHOOKS_DIR)
