#!/usr/bin/env bash
# Claude Code status line replicating the Oh My Zsh "robbyrussell" theme:
#   ➜  <dir> git:(<branch>) ✗
# plus the current model name, dimmed, appended at the end.

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')

[ -z "$cwd" ] && cwd="$PWD"
dir_name=$(basename "$cwd")

# ANSI colors
GREEN='\033[0;32m'
BOLD_CYAN='\033[1;36m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
DIM='\033[2m'
RESET='\033[0m'

line=$(printf "${GREEN}➜${RESET}")
line="${line}  $(printf "${BOLD_CYAN}%s${RESET}" "$dir_name")"

if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --quiet --short HEAD 2>/dev/null)
    [ -z "$branch" ] && branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)

    if [ -n "$branch" ]; then
        line="${line} $(printf "${BLUE}git:(${RED}%s${BLUE})${RESET}" "$branch")"
        if [ -n "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ]; then
            line="${line} $(printf "${YELLOW}✗${RESET}")"
        fi
    fi
fi

if [ -n "$model" ]; then
    line="${line}  $(printf "${DIM}%s${RESET}" "$model")"
fi

printf '%s\n' "$line"
