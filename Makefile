REPO := $(patsubst %/,%,$(abspath $(dir $(lastword $(MAKEFILE_LIST)))))
PUSH := HOME="$(HOME)" GLITCJ_PUSH_STAMP="$(STAMP)" bash "$(REPO)/scripts/push.sh"
STAMP := $(shell date +%Y%m%d-%H%M%S)

CLAUDE_DEST := $(HOME)/.claude-glitcj
CODEX_DEST  := $(HOME)/.codex-glitcj

.DEFAULT_GOAL := help
.PHONY: help push-zshrc push-vimrc push-claude-glitcj push-codex-glitcj push-everything

help:
	@echo "glitcj env ($(REPO))"
	@echo
	@echo "  make push-zshrc          .zshrc  -> $(HOME)/.zshrc"
	@echo "  make push-vimrc          .vimrc  -> $(HOME)/.vimrc"
	@echo "  make push-claude-glitcj  claude/ -> $(CLAUDE_DEST)/"
	@echo "  make push-codex-glitcj   codex/  -> $(CODEX_DEST)/"
	@echo "  make push-everything     all of the above, after a prompt (YES=1 to skip it)"
	@echo
	@echo "Overwritten files are backed up to $(HOME)/.glitcj-env-backups/<timestamp>/"

push-zshrc:
	@echo "push-zshrc"
	@$(PUSH) zshrc "$(REPO)" "$(HOME)/.zshrc"

push-vimrc:
	@echo "push-vimrc"
	@$(PUSH) file "$(REPO)/.vimrc" "$(HOME)/.vimrc"

# Merges into the target: login, history and sessions already there are left alone.
push-claude-glitcj:
	@echo "push-claude-glitcj"
	@$(PUSH) dir "$(REPO)/claude" "$(CLAUDE_DEST)"

# config.toml is seed-only: codex writes its own state (project trust, plugins) into it.
push-codex-glitcj:
	@echo "push-codex-glitcj"
	@$(PUSH) dir "$(REPO)/codex" "$(CODEX_DEST)" config.toml

push-everything:
	@echo "This will write:"
	@echo "  $(HOME)/.zshrc"
	@echo "  $(HOME)/.vimrc"
	@echo "  $(CLAUDE_DEST)/"
	@echo "  $(CODEX_DEST)/"
	@echo "Existing files that differ are backed up to $(HOME)/.glitcj-env-backups/$(STAMP)/"
	@if [ "$(YES)" != "1" ]; then \
		printf "Continue? [y/N] "; read ans; \
		case "$$ans" in y|Y|yes|YES) ;; *) echo "Aborted."; exit 1 ;; esac; \
	fi
	@$(MAKE) --no-print-directory -f "$(REPO)/Makefile" STAMP="$(STAMP)" \
		push-zshrc push-vimrc push-claude-glitcj push-codex-glitcj
	@echo "Done. Open a new shell or run: source ~/.zshrc"
