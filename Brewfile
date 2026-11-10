# Everything this Mac needs, grouped by what it's for.
#   Install:        brew bundle --file=~/dotfiles/Brewfile
#   What's missing: brewcheck
#   Add something:  brew bundle add <name>   (or --cask / --npm / --vscode)
# Only things I actually use go in here.

tap "stripe/stripe-cli"

# ---- Shell & git (wired up in zsh/ and git/) ---------------------------------
brew "git"
brew "gh"
brew "glab"                  # GitLab CLI
brew "git-delta"             # git diff pager
brew "gitleaks"              # pre-commit secret scan for this repo
brew "fzf"                   # Ctrl-R history, Ctrl-T files
brew "fd"                    # file finder (fzf uses it)
brew "ripgrep"               # code search: rg
brew "zoxide"                # z <dir>
brew "eza"                   # ls
brew "bat"                   # cat

# ---- Runtimes & package managers ---------------------------------------------
# Node comes from nvm (install.sh), Python from uv.
brew "bun"
brew "pnpm"
brew "uv"

# ---- Databases ---------------------------------------------------------------
brew "postgresql@18", restart_service: :changed
brew "redis", restart_service: :changed

# ---- Mobile: Expo, iOS, Android ----------------------------------------------
brew "cocoapods"
brew "xcodegen"
brew "mas"                   # App Store CLI, installs the mas lines below
mas "Xcode", id: 497799835
mas "Apple Configurator", id: 1037126344
mas "Developer", id: 640199958
cask "android-studio"
cask "zulu@17"               # JDK for Android builds (JAVA_HOME in zshrc)

# ---- Deploy & services -------------------------------------------------------
brew "railway"
brew "stripe/stripe-cli/stripe", trusted: true

# ---- Utilities ---------------------------------------------------------------
brew "ffmpeg"                # also lets yt-dlp merge video and audio
brew "poppler"               # pdftotext
brew "mole"                  # Mac cleanup: mo

# ---- Dev apps ----------------------------------------------------------------
cask "claude"
cask "docker-desktop"
cask "git-credential-manager"
cask "google-chrome"
cask "postman"
cask "raycast"
cask "t3-code"
cask "tailscale-app"
cask "termius"
cask "visual-studio-code"
cask "wezterm"
cask "zerotier-one"

# ---- Everyday apps -----------------------------------------------------------
cask "anydesk"
cask "discord"
cask "google-drive"
cask "motrix"
cask "obsidian"
cask "omnidisksweeper"
cask "recordly"
cask "slack"
cask "spotify"
cask "surfshark"
cask "telegram"
cask "vlc"
cask "whatsapp"
cask "wpsoffice"

# ---- VS Code extensions (only for what my projects use) ----------------------
vscode "anthropic.claude-code"
vscode "biomejs.biome"
vscode "oxc.oxc-vscode"
vscode "dbaeumer.vscode-eslint"
vscode "esbenp.prettier-vscode"
vscode "bradlc.vscode-tailwindcss"
vscode "yoavbls.pretty-ts-errors"
vscode "unifiedjs.vscode-mdx"
vscode "ms-python.python"      # also installs Pylance, debugger, environments
vscode "mtxr.sqltools"
vscode "mtxr.sqltools-driver-pg"
vscode "eamodio.gitlens"

# ---- Global CLIs -------------------------------------------------------------
uv "yt-dlp"
npm "@openai/codex"            # T3 Code runs on it
npm "eas-cli"                  # Expo builds
