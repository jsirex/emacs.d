.PHONY: compile
compile: init.el README.org clean
	@emacs -Q --batch -l 'compile.el'
	@echo "Done!"

.PHONY: clean
clean:
	@rm -f early-init.elc init.elc README.el README.elc
