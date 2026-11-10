# Aliases and small functions, loaded by zshrc.
# Oh My Zsh's git plugin already adds the g* shortcuts (gst, gco, gp, ...): run `alias | grep git`.

# ---- Shell -------------------------------------------------------------------
alias reload='exec zsh'
alias dot='cd "$DOTFILES"'

# ---- Files -------------------------------------------------------------------
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first'
  alias ll='eza -l --git --group-directories-first --time-style=relative'
  alias la='eza -la --git --group-directories-first --time-style=relative'
  alias lt='eza --tree --level=2 --git-ignore'
fi
(( $+commands[bat] )) && alias cat='bat --paging=never --style=plain'

mkcd() { mkdir -p "$1" && cd "$1"; }

# ---- Ports -------------------------------------------------------------------
# port 3000      → what's listening on 3000
# killport 3000  → stop it
port() { lsof -nP -iTCP:"$1" -sTCP:LISTEN; }
killport() {
  local pids
  pids=$(lsof -t -iTCP:"$1" -sTCP:LISTEN)
  [[ -z $pids ]] && { echo "Nothing is listening on port $1"; return 1; }
  kill ${(f)pids} && echo "Stopped PID ${(j:, :)${(f)pids}} on port $1"
}

# ---- Homebrew ----------------------------------------------------------------
alias brewup='brew update && brew upgrade && brew cleanup'
alias brewcheck='brew bundle check --file="$DOTFILES/Brewfile" --verbose'

# ---- Network -----------------------------------------------------------------
alias localip='ipconfig getifaddr en0'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
