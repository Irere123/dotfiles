# Install everything:  brew bundle --file=~/dotfiles/Brewfile
# See what's missing:  brew bundle check --file=~/dotfiles/Brewfile --verbose
# Delete a line to stop installing something on new Macs.

# ---- Taps --------------------------------------------------------------------
tap "cameroncooke/axe"
tap "redis/redis"
tap "stripe/stripe-cli"
# tap "supabase/tap"   # uncomment along with the supabase line below

# ---- Command-line tools ------------------------------------------------------
brew "bun"
brew "cocoapods"
brew "fastlane"
brew "ffmpeg"
brew "flyctl"
brew "gh"
brew "git"
brew "glab"                  # GitLab CLI
brew "libimobiledevice"      # talk to iOS devices over USB
brew "mole"                  # Mac cleanup tool
brew "mosquitto", restart_service: :changed   # MQTT broker
brew "nmap"
brew "opencode"
brew "pnpm"
brew "poppler"               # PDF tools (pdftotext, etc.)
brew "postgresql@14"
brew "postgresql@18", restart_service: :changed
brew "qemu"
brew "redis", restart_service: :changed
brew "uv"                    # Python package/version manager
brew "xcodegen"
brew "cameroncooke/axe/axe", trusted: true    # iOS Simulator automation
brew "stripe/stripe-cli/stripe", trusted: true
# brew "supabase/tap/supabase", trusted: true

# ---- Apps --------------------------------------------------------------------
cask "android-studio"
cask "anydesk"
cask "claude"
cask "discord"
cask "docker-desktop"
cask "git-credential-manager"
cask "google-chrome"
cask "google-drive"
cask "motrix"                # download manager
cask "obsidian"
cask "omnidisksweeper"
cask "postman"
cask "raycast"
cask "recordly"
cask "redis/redis/redis"     # Redis GUI
cask "slack"
cask "spotify"
cask "surfshark"
cask "t3-code"
cask "tailscale-app"
cask "telegram"
cask "termius"
cask "visual-studio-code"
cask "vlc"
cask "wezterm"
cask "whatsapp"
cask "wpsoffice"
cask "zerotier-one"
cask "zulu@17"               # Java 17 (JAVA_HOME in zshrc points here)

# ---- VS Code extensions ------------------------------------------------------
vscode "anthropic.claude-code"
vscode "astro-build.astro-vscode"
vscode "biomejs.biome"
vscode "bradlc.vscode-tailwindcss"
vscode "dart-code.dart-code"
vscode "dart-code.flutter"
vscode "dbaeumer.vscode-eslint"
vscode "eamodio.gitlens"
vscode "esbenp.prettier-vscode"
vscode "golang.go"
vscode "llvm-vs-code-extensions.lldb-dap"
vscode "llvm-vs-code-extensions.vscode-clangd"
vscode "ms-python.debugpy"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.vscode-python-envs"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode.extension-test-runner"
vscode "ms-vsliveshare.vsliveshare"
vscode "mtxr.sqltools"
vscode "mtxr.sqltools-driver-pg"
vscode "oxc.oxc-vscode"
vscode "pgourlain.erlang"
vscode "prisma.prisma"
vscode "redhat.java"
vscode "ritwickdey.liveserver"
vscode "rooveterinaryinc.roo-cline"
vscode "rust-lang.rust-analyzer"
vscode "svelte.svelte-vscode"
vscode "swiftlang.swift-vscode"
vscode "unifiedjs.vscode-mdx"
vscode "vue.volar"
vscode "yoavbls.pretty-ts-errors"

# ---- Global CLIs via uv and npm ----------------------------------------------
# npm entries use nvm's node; install.sh installs that before running this file.
uv "yt-dlp"
npm "@openai/codex"
npm "agent-browser"
npm "eas-cli"
npm "goldie"
npm "vercel"
