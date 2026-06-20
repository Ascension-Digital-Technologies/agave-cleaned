SHELL := /usr/bin/env bash

.PHONY: help bootstrap layout metadata fmt clippy test check github-ready clean-generated docs-check map

help:
	@echo "Agave Professional developer commands"
	@echo ""
	@echo "  make bootstrap        Check local tool availability"
	@echo "  make layout           Validate repository layout and Cargo paths"
	@echo "  make metadata         Run cargo metadata without compiling"
	@echo "  make fmt              Check Rust formatting"
	@echo "  make clippy           Run workspace clippy"
	@echo "  make test             Run nextest workspace profile"
	@echo "  make github-ready     Run lightweight GitHub-readiness checks"
	@echo "  make clean-generated  Remove generated local caches"
	@echo "  make map              Print compact top-level repository map"
	@echo "  make check            Run the standard local development gate"

bootstrap:
	scripts/dev/bootstrap.sh

layout:
	scripts/dev/layout.sh

metadata:
	./cargo metadata --no-deps

fmt:
	scripts/dev/fmt.sh

clippy:
	scripts/dev/clippy.sh

test:
	scripts/dev/test.sh

docs-check:
	python3 scripts/dev/check-doc-links.py

github-ready:
	scripts/dev/github-ready.sh

clean-generated:
	scripts/dev/clean-generated.sh

map:
	python3 scripts/repo-map.py

check:
	scripts/dev/check.sh
