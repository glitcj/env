# env

One repo that holds my Mac dev environment. Edit things here, then push them into `$HOME`.

## Setup on a new Mac

```sh
git clone <this repo> && cd env
make push-everything
```

## Targets

| Target | Source | Destination |
|---|---|---|
| `make push-zshrc` | `.zshrc` | `~/.zshrc` |
| `make push-vimrc` | `.vimrc` | `~/.vimrc` |
| `make push-claude-glitcj` | `claude/` | `~/.claude-glitcj/` |
| `make push-codex-glitcj` | `codex/` | `~/.codex-glitcj/` |
| `make push-everything` | all of the above | asks first; `YES=1` skips the prompt |

- Any file that exists and differs is backed up to `~/.glitcj-env-backups/<timestamp>/` before being overwritten.
- The Claude and Codex pushes merge into the target, so login and history there survive.
- `codex/config.toml` is only copied when the target has none, since Codex writes its own state into it.
- The sources are `claude/` and `codex/` rather than `.claude/` and `.codex/` so Claude Code does not also load them as project config for this repo.

## What the pushed `.zshrc` gives you

`make push-zshrc` prepends `export GLITCJ_ENV_REPO=<path of this repo>` to `~/.zshrc`, so the shell knows where the repo lives.

| Command | Does |
|---|---|
| `claude-glitcj` | Claude Code using `~/.claude-glitcj` |
| `codex-glitcj` | Codex using `~/.codex-glitcj` |
| `glitcj-config` | sources `glitcj-config.sh` (SSH key + git identity) |
| `glitcj-env` | `cd` into this repo |
| `get-env` | exports everything in this repo's git-ignored `.env` |
| `get-env --pull` | downloads `.env` from `GLITCJ_ENV_S3_URI` (set in `.zshrc`) first |
