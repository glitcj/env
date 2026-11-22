# Push this repo's config into $HOME. Flags go after the recipe name:
#   just push-everything --yes
#   just push-vimrc --home /some/other/dir
# `just --usage <recipe>` shows a recipe's flags.

repo := justfile_directory()
push := "bash '" + repo / "scripts/push.sh" + "'"

# The backtick runs once per invocation, so all pushes share one backup dir.
export GLITCJ_PUSH_STAMP := `date +%Y%m%d-%H%M%S`

# Show the targets and where they write
[default]
help:
    @echo "glitcj env ({{ repo }})"
    @echo
    @echo "  just push-zshrc          .zshrc  -> ~/.zshrc"
    @echo "  just push-vimrc          .vimrc  -> ~/.vimrc"
    @echo "  just push-claude-glitcj  claude/ -> ~/.claude-glitcj/"
    @echo "  just push-codex-glitcj   codex/ + shared skills -> ~/.codex-glitcj/"
    @echo "  just push-everything     all of the above, after a prompt"
    @echo
    @echo "Flags:  --home DIR   push into DIR instead of ~ (every push recipe)"
    @echo "        --yes, -y    skip the prompt (push-everything)"
    @echo
    @echo "Overwritten files are backed up to ~/.glitcj-env-backups/<timestamp>/"

# .zshrc -> ~/.zshrc, with a header that records this repo's path
[arg("home", long)]
push-zshrc home=env_var('HOME'):
    @echo "push-zshrc"
    @HOME='{{ home }}' {{ push }} zshrc '{{ repo }}' '{{ home }}/.zshrc'

# .vimrc -> ~/.vimrc
[arg("home", long)]
push-vimrc home=env_var('HOME'):
    @echo "push-vimrc"
    @HOME='{{ home }}' {{ push }} file '{{ repo }}/.vimrc' '{{ home }}/.vimrc'

# claude/ -> ~/.claude-glitcj/ (merges: login, history and sessions there are left alone)
[arg("home", long)]
push-claude-glitcj home=env_var('HOME'):
    @echo "push-claude-glitcj"
    @HOME='{{ home }}' {{ push }} dir '{{ repo }}/claude' '{{ home }}/.claude-glitcj'

# Push Codex settings and the skills shared with Claude. config.toml is seed-only.
[arg("home", long)]
push-codex-glitcj home=env_var('HOME'):
    @echo "push-codex-glitcj"
    @HOME='{{ home }}' {{ push }} dir '{{ repo }}/codex' '{{ home }}/.codex-glitcj' config.toml
    @HOME='{{ home }}' {{ push }} dir '{{ repo }}/claude/skills' '{{ home }}/.codex-glitcj/skills'

# Run every push after a confirmation prompt
[arg("yes", long, short="y", value="true")]
[arg("home", long)]
push-everything yes="false" home=env_var('HOME'): (_confirm yes home) (push-zshrc home) (push-vimrc home) (push-claude-glitcj home) (push-codex-glitcj home)
    @echo "Done. Open a new shell or run: source ~/.zshrc"

_confirm yes home:
    #!/usr/bin/env bash
    echo "This will write:"
    echo "  {{ home }}/.zshrc"
    echo "  {{ home }}/.vimrc"
    echo "  {{ home }}/.claude-glitcj/"
    echo "  {{ home }}/.codex-glitcj/"
    echo "Existing files that differ are backed up to {{ home }}/.glitcj-env-backups/$GLITCJ_PUSH_STAMP/"
    if [ "{{ yes }}" != "true" ]; then
        printf "Continue? [y/N] "; read -r ans
        case "$ans" in y|Y|yes|YES) ;; *) echo "Aborted."; exit 1 ;; esac
    fi
