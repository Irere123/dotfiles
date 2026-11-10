#!/usr/bin/env bash
# Developer-friendly macOS settings. Run once per Mac: ./macos.sh
# Read through it first and delete anything you don't want.
# Some changes only apply after you log out and back in.

set -euo pipefail

echo "==> Keyboard: fast key repeat, no autocorrect or smart punctuation"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false   # hold a key to repeat it, not show accents
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false   # keep " and ' straight
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false    # keep -- as --
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

echo "==> Finder: show extensions, hidden files, path and status bars"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string SCcf   # search the current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "==> Don't litter network and USB drives with .DS_Store files"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

echo "==> Screenshots go to ~/Pictures/Screenshots instead of the Desktop"
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots"

echo "==> Dock: don't show recent apps"
defaults write com.apple.dock show-recents -bool false

echo "==> Expand save and print dialogs by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

echo "==> Touch ID for sudo (asks for your password once)"
if [[ ! -f /etc/pam.d/sudo_local && -f /etc/pam.d/sudo_local.template ]]; then
  sed 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local >/dev/null
fi

killall Finder Dock SystemUIServer 2>/dev/null || true
echo "Done. Log out and back in for the keyboard changes to apply."
