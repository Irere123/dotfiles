# dotfiles

My Mac setup: shell, git, editor config, and every app and CLI I use.

## Set up a new Mac

1. Install Homebrew (this also installs Xcode Command Line Tools):

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   eval "$(/opt/homebrew/bin/brew shellenv)"
   ```

2. Install the GitHub CLI and sign in. Pick **SSH** when asked, and let it
   create and upload a new SSH key for this Mac.

   ```sh
   brew install gh
   gh auth login
   ```

3. Clone this repo and run the installer:

   ```sh
   gh repo clone Irere123/dotfiles ~/dotfiles
   ~/dotfiles/install.sh
   ```

4. Open a new terminal window, then follow the checklist the installer prints
   (API keys, App Store apps, signing in to apps).

The installer is safe to run again. It skips what's already installed, and any
existing config file it replaces is moved to `~/.dotfiles-backup/<timestamp>/`.

## What's in here

| Path | Linked to | What it is |
| --- | --- | --- |
| `Brewfile` | — | CLI tools, apps, VS Code extensions, global npm/uv tools |
| `zsh/zshrc` | `~/.zshrc` | Oh My Zsh, PATH, nvm, toolchains |
| `zsh/zprofile` | `~/.zprofile` | Homebrew and python.org Python on PATH |
| `git/gitconfig` | `~/.gitconfig` | Name, email, credential helpers |
| `git/ignore` | `~/.config/git/ignore` | Global gitignore |
| `vscode/settings.json` | VS Code user settings | |
| `zed/settings.json` | `~/.config/zed/settings.json` | |
| `claude/` | `~/.claude/` | Claude Code status line, rules, and settings (copied, not linked) |

Config files are **symlinked**, so editing `~/.zshrc` edits the file in this
repo. Commit and push to keep it backed up.

## Secrets

Never put API keys in this repo. They go in `~/.zshrc.local`, which `.zshrc`
loads at the end and git ignores. Copy that file to a new Mac yourself (or
re-create it from your password manager).

## Day-to-day

```sh
cd ~/dotfiles

# Installed something new with brew/npm/uv? Add it to the Brewfile:
brew bundle add <name>                 # formula
brew bundle add --cask <name>          # app
brew bundle add --npm <name>           # global npm package

# Check this Mac has everything in the Brewfile:
brew bundle check --verbose

# Re-link configs (e.g. if an app replaced a symlink with a plain file):
./install.sh --link

git add -A && git commit -m "Update dotfiles" && git push
```
