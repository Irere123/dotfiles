# dotfiles

My Mac dev setup: shell, git, editors, and every app and CLI I use.

## New Mac

1. Open the **App Store** and sign in (so Xcode can install).
2. Install Homebrew, then the GitHub CLI. Pick **SSH** when `gh` asks, and let
   it create a key for this Mac.

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   eval "$(/opt/homebrew/bin/brew shellenv)"
   brew install gh && gh auth login
   ```

3. Clone and install:

   ```sh
   gh repo clone Irere123/dotfiles ~/dotfiles
   ~/dotfiles/install.sh
   ~/dotfiles/macos.sh     # optional: dev-friendly macOS settings
   ```

4. Open a new terminal and follow the checklist the installer prints.

`install.sh` is safe to re-run. It skips what's installed, and any config file
it replaces is moved to `~/.dotfiles-backup/<timestamp>/`.

## What you get

**Shell**: Oh My Zsh, autosuggestions (Tab accepts), syntax highlighting, and
a ~0.2s startup, down from ~0.9s (nvm loads without its slow auto-activation step).

| Key / command | Does |
| --- | --- |
| `Ctrl-R` | fuzzy-search shell history |
| `Ctrl-T` / `Alt-C` | fuzzy-pick a file / `cd` into a folder |
| `z <name>` | jump to a folder you've visited (`zi` to pick) |
| `ll`, `la`, `lt` | list with git status, all files, tree |
| `lg` | lazygit |
| `port 3000` / `killport 3000` | see / stop what's listening on a port |
| `mkcd dir` | make a folder and `cd` into it |
| `dot`, `reload` | go to this repo, restart the shell |
| `brewup`, `brewcheck` | upgrade everything, check the Brewfile is installed |

**Git**: readable diffs with delta, `pull` rebases, `push` sets upstream
automatically, conflicts show the original code (`zdiff3`), branches sorted by
recent. Aliases: `git st`, `git lg`, `git last`, `git undo`, `git amend`,
`git recent`.

**macOS** (`macos.sh`): fast key repeat, no smart quotes or autocorrect,
Finder shows extensions and hidden files, screenshots go to
`~/Pictures/Screenshots`, Touch ID for `sudo`.

## Layout

| Path | Linked to |
| --- | --- |
| `Brewfile` | CLI tools, apps, App Store apps, VS Code extensions, npm/uv globals |
| `zsh/zshrc`, `zsh/zprofile` | `~/.zshrc`, `~/.zprofile` |
| `zsh/aliases.zsh` | loaded by `zshrc` |
| `git/gitconfig`, `git/ignore` | `~/.gitconfig`, `~/.config/git/ignore` |
| `vscode/settings.json` | VS Code user settings |
| `zed/settings.json` | `~/.config/zed/settings.json` |
| `claude/` | `~/.claude/` (`settings.json` is copied, not linked) |
| `macos.sh` | run by hand |

Config files are symlinks, so editing `~/.zshrc` edits this repo. Commit and
push to keep it backed up.

## Secrets and per-machine settings

Never commit secrets. A pre-commit hook runs `gitleaks` and blocks commits
that contain one.

- Shell secrets: `~/.zshrc.local` (e.g. `export DAISY_API_KEY=...`)
- Git overrides: `~/.gitconfig.local` (e.g. a work email)

Both are loaded automatically and never committed. Copy them to a new Mac by
hand or from your password manager.

## Day to day

```sh
dot                                   # cd ~/dotfiles
brew bundle add <name>                # track a new formula
brew bundle add --cask <name>         # ...an app
brew bundle add --npm <name>          # ...a global npm package
brewcheck                             # anything missing on this Mac?
./install.sh --link                   # re-link if an app replaced a symlink
```
