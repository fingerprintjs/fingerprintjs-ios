.DEFAULT_GOAL := help

.PHONY: help lint tests

help:
	@cat $(MAKEFILE_LIST)

lint:
	@./Scripts/lint_code.sh

tests:
	@./Scripts/run_tests.sh
