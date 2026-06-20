SHELL := /usr/bin/env bash

.PHONY: help bootstrap env layout metadata build fmt fmt-fix clippy test bench quick-check check full-check github-ready clean-generated docs-check map summary source-manifest verify-source-integrity verify-upstream upstream-path clean-path

help:
	@echo "Agave Professional developer commands"
	@echo ""
	@echo "Setup and diagnostics:"
	@echo "  make bootstrap        Check local tool availability"
	@echo "  make env              Print environment and workspace diagnostics"
	@echo "  make layout           Validate repository layout, Cargo paths, and workspace summary"
	@echo "  make map              Print compact top-level repository map"
	@echo "  make summary          Print Cargo workspace summary"
	@echo "  make upstream-path P=<cleaned-path>  Translate cleaned path to upstream layout"
	@echo "  make clean-path P=<upstream-path>   Translate upstream path to cleaned layout"
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
	@echo "  make source-manifest  Regenerate docs/source-manifest.json"
	@echo "  make verify-source-integrity  Verify source files against the manifest"
	@echo "  make verify-upstream UPSTREAM=/path/to/agave  Compare with upstream checkout"

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

source-manifest:
	scripts/dev/generate-source-manifest.sh

verify-source-integrity:
	scripts/dev/verify-source-integrity.sh

verify-upstream:
	@if [ -z "$(UPSTREAM)" ]; then echo "usage: make verify-upstream UPSTREAM=/path/to/agave"; exit 2; fi
	scripts/dev/verify-upstream.sh "$(UPSTREAM)"

upstream-path:
	@if [ -z "$(P)" ]; then echo "usage: make upstream-path P=crates/programs/sbf"; exit 2; fi
	scripts/dev/upstream-path.sh "$(P)"

clean-path:
	@if [ -z "$(P)" ]; then echo "usage: make clean-path P=programs/sbf"; exit 2; fi
	scripts/dev/clean-path.sh "$(P)"
