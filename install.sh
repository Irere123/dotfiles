#!/usr/bin/env bash
# Set up a Mac from this repo. Safe to run again; it skips what's already done.
#
#   ./install.sh          full setup (Homebrew, Node, Brewfile, Oh My Zsh, config links)
#   ./install.sh --link   only (re)create the config symlinks
#   ./macos.sh            developer-friendly macOS settings (run separately)
#
# Existing files that would be replaced are moved to ~/.dotfiles-backup/<timestamp>/.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
NVM_VERSION="v0.40.3"
NODE_VERSION="25"

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }

# link <path in repo> <target>: point target at the repo file, backing up whatever was there.
link() {
  local src="$DOTFILES/$1" dst="$2"
  [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]] && return 0
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" || -L "$dst" ]]; then
    local rel="${dst#"$HOME"/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    mv "$dst" "$BACKUP_DIR/$rel"
    warn "moved old $dst to $BACKUP_DIR/$rel"
  fi
  ln -s "$src" "$dst"
  info "linked $dst"
}

link_configs() {
  info "Linking config files"
  link zsh/zshrc               "$HOME/.zshrc"
  link zsh/zprofile            "$HOME/.zprofile"
  link git/gitconfig           "$HOME/.gitconfig"
  link git/ignore              "$HOME/.config/git/ignore"
  link vscode/settings.json    "$HOME/Library/Application Support/Code/User/settings.json"
  link zed/settings.json       "$HOME/.config/zed/settings.json"
  link claude/statusline.sh    "$HOME/.claude/statusline.sh"
  link claude/rules/context7.md "$HOME/.claude/rules/context7.md"

  # Claude Code rewrites its own settings.json, which would break a symlink,
  # so copy it once instead.
  if [[ ! -e "$HOME/.claude/settings.json" ]]; then
    cp "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
    info "copied Claude Code settings.json"
  fi

  # Scan this repo for secrets before every commit (see .githooks/pre-commit).
  git -C "$DOTFILES" config core.hooksPath .githooks

  # Secrets live here, outside git.
  if [[ ! -e "$HOME/.zshrc.local" ]]; then
    printf '# Secrets and machine-specific settings. Not tracked in git.\n# export SOME_API_KEY="..."\n' > "$HOME/.zshrc.local"
    chmod 600 "$HOME/.zshrc.local"
    info "created ~/.zshrc.local for your API keys"
  fi
}

install_homebrew() {
  if [[ ! -x /opt/homebrew/bin/brew ]]; then
    info "Installing Homebrew (also installs Xcode Command Line Tools)"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_node() {
  export NVM_DIR="$HOME/.nvm"
  if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
    info "Installing nvm $NVM_VERSION"
    # PROFILE=/dev/null stops the installer from editing ~/.zshrc; ours already loads nvm.
    PROFILE=/dev/null bash -c "curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh | bash"
  fi
  info "Installing Node $NODE_VERSION"
  set +eu   # nvm doesn't work under strict mode
  # shellcheck source=/dev/null
  source "$NVM_DIR/nvm.sh"
  nvm install "$NODE_VERSION" && nvm alias default "$NODE_VERSION"
  local status=$?
  set -eu
  [[ $status -eq 0 ]] || warn "nvm couldn't install Node $NODE_VERSION"
}

install_brewfile() {
  info "Installing everything in the Brewfile (this takes a while)"
  brew bundle --file="$DOTFILES/Brewfile" ||
    warn "some Brewfile entries failed; run ./install.sh again to retry them"
}

install_oh_my_zsh() {
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    info "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
  fi
  local custom="$HOME/.oh-my-zsh/custom/plugins" repo
  for repo in zsh-users/zsh-autosuggestions zsh-users/zsh-syntax-highlighting zdharma-continuum/fast-syntax-highlighting; do
    if [[ ! -d "$custom/${repo#*/}" ]]; then
      info "Adding zsh plugin ${repo#*/}"
      git clone --depth 1 "https://github.com/$repo.git" "$custom/${repo#*/}"
    fi
  done
}

install_claude_code() {
  if ! command -v claude >/dev/null && [[ ! -x "$HOME/.local/bin/claude" ]]; then
    info "Installing Claude Code"
    curl -fsSL https://claude.ai/install.sh | bash
  fi
}

main() {
  if [[ "${1:-}" == "--link" ]]; then
    link_configs
    return
  fi

  install_homebrew
  link_configs        # before Oh My Zsh, so its installer keeps our .zshrc
  install_node        # before the Brewfile, which has npm entries
  install_brewfile
  install_oh_my_zsh
  install_claude_code

  cat <<'EOF'

All done. Still to do by hand:
  1. Open a new terminal window so the new shell config loads.
  2. Put your API keys in ~/.zshrc.local (e.g. DAISY_API_KEY).
  3. Optional: run ~/dotfiles/macos.sh for developer-friendly macOS settings.
  4. Install the apps Homebrew can't: Cisco Secure Client, EShare, copybox,
     App Sprint ASO.
  5. Open Xcode and Android Studio once to finish their setup.
  6. Sign in to your apps (Chrome, Slack, Docker, Tailscale, ...).
EOF
}

main "$@"
