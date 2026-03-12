#!/usr/bin/env bash
set -euo pipefail

repo_root="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
repo_gitconfig="$repo_root/config/gitconfig"
repo_gitignore="$repo_root/config/gitignore_global"

if [[ ! -f "$repo_gitconfig" ]]; then
  echo "Missing file: $repo_gitconfig" >&2
  exit 1
fi

if [[ ! -f "$repo_gitignore" ]]; then
  echo "Missing file: $repo_gitignore" >&2
  exit 1
fi

existing_includes="$(git config --global --get-all include.path || true)"
if ! grep -Fxq "$repo_gitconfig" <<<"$existing_includes"; then
  git config --global --add include.path "$repo_gitconfig"
  echo "Added include.path: $repo_gitconfig"
else
  echo "include.path already present: $repo_gitconfig"
fi

git config --global core.excludesfile "$repo_gitignore"
echo "Set core.excludesfile: $repo_gitignore"

echo
echo "Git setup complete."
echo "Verify with: git config --global --list --show-origin"
