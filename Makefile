SHELL := /usr/bin/env bash

.PHONY: help bootstrap env layout metadata build fmt fmt-fix clippy test bench quick-check check full-check github-ready clean-generated docs-check map summary

help:
	@echo "Agave Professional developer commands"
	@echo ""
	@echo "Setup and diagnostics:"
	@echo "  make bootstrap        Check local tool availability"
	@echo "  make env              Print environment and workspace diagnostics"
	@echo "  make layout           Validate repository layout, Cargo paths, and workspace summary"
	@echo "  make map              Print compact top-level repository map"
	@echo "  make summary          Print Cargo workspace summary"
	@echo ""
	@echo "Cargo helpers:"
	@echo "  make metadata         Run cargo metadata without compiling"
	@echo "  make build            Build the workspace with locked dependencies"
	@echo "  make fmt              Check Rust formatting"
	@echo "  make fmt-fix          Apply Rust formatting"
	@echo "  make clippy           Run workspace clippy"
	@echo "  make test             Run nextest or cargo test fallback"
	@echo "  make bench            Run nightly workspace benchmarks"
	@echo ""
	@echo "Gates:"
	@echo "  make github-ready     Run lightweight GitHub-readiness checks"
	@echo "  make quick-check      Run GitHub-readiness checks plus cargo metadata"
	@echo "  make check            Run the standard local development gate"
	@echo "  make full-check       Run the full local gate including tests"
	@echo "  make clean-generated  Remove generated local caches"

bootstrap:
	scripts/dev/bootstrap.sh

env:
	scripts/dev/env.sh

layout:
	scripts/dev/layout.sh

metadata:
	scripts/dev/metadata.sh

build:
	scripts/dev/build.sh

fmt:
	scripts/dev/fmt.sh

fmt-fix:
	scripts/dev/fmt-fix.sh

clippy:
	scripts/dev/clippy.sh

test:
	scripts/dev/test.sh

bench:
	scripts/dev/bench.sh

docs-check:
	python3 scripts/dev/check-doc-links.py

github-ready:
	scripts/dev/github-ready.sh

quick-check:
	scripts/dev/quick-check.sh

clean-generated:
	scripts/dev/clean-generated.sh

map:
	python3 scripts/repo-map.py

summary:
	python3 scripts/workspace-summary.py

check:
	scripts/dev/check.sh

full-check:
	scripts/dev/full-check.sh
