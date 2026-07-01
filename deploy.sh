#!/usr/bin/env bash
# Redeploy the Touch This dashboard to GitHub Pages.
# Usage: ./deploy.sh ["commit message"]
#
# The source of truth is the file in the Obsidian vault. This script copies the
# latest version in as index.html, commits, and pushes. GitHub Pages rebuilds
# automatically (usually within a minute).
set -euo pipefail

SRC="/Users/haritgillar/Desktop/Personal/Obsidian/🧠 wiki/health/touch-this-dashboard.html"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp "$SRC" "$DIR/index.html"
cd "$DIR"
git add index.html
if git diff --cached --quiet; then
  echo "No changes to deploy."
  exit 0
fi
git commit -m "${1:-Update dashboard}"
git push
echo "Deployed. Live at https://harit556.github.io/touch-this/"
