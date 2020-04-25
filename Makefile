.PHONY: compile
compile:
	@emacs --batch -l 'compile.el'

.PHONY: clean
clean:
	@rm -f early-init.elc init.elc
