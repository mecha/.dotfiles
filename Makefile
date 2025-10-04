STOW_PACKAGES := home:$(HOME) config:$(HOME)/.config local-bin:$(HOME)/.local/bin
STOW_ARGS :=

.PHONY: help install uninstall reinstall

help:
	@echo "Usage:"
	@echo "  make install"
	@echo "  make uninstall"
	@echo "  make reinstall"

install:
	@for pair in $(STOW_PACKAGES); do \
		pkg=$${pair%%:*}; \
		target=$${pair#*:}; \
		echo "Stowing $$pkg → $$target"; \
		mkdir -p "$$target"; \
		stow $(STOW_ARGS) -t $$target $$pkg; \
	done

uninstall:
	@for pair in $(STOW_PACKAGES); do \
		pkg=$${pair%%:*}; \
		target=$${pair#*:}; \
		echo "Unstowing $$pkg from $$target"; \
		stow -D -t $$target $$pkg; \
	done

reinstall: uninstall install
	hyprctl reload
