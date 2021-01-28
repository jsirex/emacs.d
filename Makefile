EMACS_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Makefile can be called from different work trees, so be explicit
EMACS_ARGS :=
EMACS_ARGS += --chdir $(EMACS_DIR)
EMACS_ARGS += --init-directory $(EMACS_DIR)
EMACS_ARGS += --debug-init

.DEFAULT_GOAL := compile

.PHONY: compile
compile: early-init.elc init.elc

%.elc: %.el
	emacs $(EMACS_ARGS) --batch -f batch-byte-compile $<

.PHONY: clean
clean:
	@rm -f early-init.elc init.elc

.PHONY: deep-clean
deep-clean:
	@git clean -fdx
