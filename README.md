# env

One repo that holds my Mac dev environment. Edit things here, then push them into `$HOME`.

## Setup on a new Mac

```sh
brew install just
git clone <this repo> && cd env
just push-everything
```

## Recipes

| Recipe | Source | Destination |
|---|---|---|
| `just push-zshrc` | `.zshrc` | `~/.zshrc` |
| `just push-vimrc` | `.vimrc` | `~/.vimrc` |
| `just push-claude-glitcj` | `claude/` | `~/.claude-glitcj/` |
| `just push-codex-glitcj` | `codex/` | `~/.codex-glitcj/` |
| `just push-everything` | all of the above | asks first; `--yes` (or `-y`) skips the prompt |

- `just` on its own lists the recipes; `just --usage <recipe>` shows a recipe's flags.
- Every push recipe takes `--home DIR` to push into another directory instead of `~`.
- Any file that exists and differs is backed up to `~/.glitcj-env-backups/<timestamp>/` before being overwritten.
- The Claude and Codex pushes merge into the target, so login and history there survive.
- `codex/config.toml` is only copied when the target has none, since Codex writes its own state into it.
- The sources are `claude/` and `codex/` rather than `.claude/` and `.codex/` so Claude Code does not also load them as project config for this repo.

## What the pushed `.zshrc` gives you

`just push-zshrc` prepends `export GLITCJ_ENV_REPO=<path of this repo>` to `~/.zshrc`, so the shell knows where the repo lives.

| Command | Does |
|---|---|
| `claude-glitcj` | Claude Code using `~/.claude-glitcj` |
| `codex-glitcj` | Codex using `~/.codex-glitcj` |
| `glitcj-config` | sources `glitcj-config.sh` (SSH key + git identity) |
| `glitcj-env` | `cd` into this repo |
| `get-env` | exports everything in this repo's git-ignored `.env` |
| `get-env --pull` | downloads `.env` from `GLITCJ_ENV_S3_URI` (set in `.zshrc`) first |
