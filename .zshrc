export PATH="$HOME/.local/bin:$PATH"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/alhabib/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions

# add to ~/.bashrc or ~/.zshrc
alias claude-personal='CLAUDE_CONFIG_DIR=~/.claude claude'
alias claude-glitcj='CLAUDE_CONFIG_DIR=~/.claude claude'
alias claude-ping='CLAUDE_CONFIG_DIR=~/.claude-ping claude'
alias glitcj-config='source ~/zsh-stuff/glitcj-config.sh'

# ping-config: in a repo with tbd/ scripts, use those; otherwise use the
# workspace-wide scripts in ~/Desktop/ping-repos/ignored (all repos at once).
unalias ping-config 2>/dev/null
ping-config() {
  if [ -f tbd/ping-config.sh ] && [ -f tbd/setup-dev-session.sh ]; then
    source tbd/ping-config.sh && source tbd/setup-dev-session.sh
  else
    source ~/Desktop/ping-repos/ignored/ping-config.sh && source ~/Desktop/ping-repos/ignored/setup-dev-session.sh
  fi
}

# --- Per-directory Terminal.app profile (direnv-style). Reads the nearest .terminal-profile file. ---
_tp_default="Novel"            # everyday profile, restored when leaving a bound directory
_tp_find() {
  local d=$PWD
  while [[ $d != / ]]; do
    [[ -f $d/.terminal-profile ]] && { cat "$d/.terminal-profile"; return }
    d=${d:h}
  done
}
_tp_apply() {
  [[ $TERM_PROGRAM == Apple_Terminal ]] || return
  local want; want=$(_tp_find); want=${want:-$_tp_default}
  [[ $want == $_TP_CURRENT ]] && return
  _TP_CURRENT=$want
  osascript - "$TTY" "$want" <<'APPLESCRIPT' >/dev/null 2>&1
on run {theTTY, theProfile}
  tell application "Terminal"
    repeat with w in windows
      repeat with t in tabs of w
        if tty of t is theTTY then set current settings of t to settings set theProfile
      end repeat
    end repeat
  end tell
end run
APPLESCRIPT
}
autoload -Uz add-zsh-hook
add-zsh-hook chpwd _tp_apply
_tp_apply

# Cortex CLI completion (disable via /settings in cortex)
[[ -s ~/.zsh/completions/cortex.zsh ]] && source ~/.zsh/completions/cortex.zsh
