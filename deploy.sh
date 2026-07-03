#!/usr/bin/env bash
# Redeploy the Touch This dashboard to GitHub Pages.
# Usage: ./deploy.sh ["commit message"]
#
# The source of truth is the file in the Obsidian vault. This script copies the
# latest version in as index.html, commits, pushes, and then waits for the
# GitHub Pages build to finish so a failed build is never mistaken for "live".
# Note: a .nojekyll file in this repo disables Jekyll; do not delete it.
set -euo pipefail

SRC="/Users/haritgillar/Desktop/Personal/Obsidian/🧠 wiki/health/touch-this-dashboard.html"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="Harit556/touch-this"
URL="https://harit556.github.io/touch-this/"

cp "$SRC" "$DIR/index.html"
cd "$DIR"
git add index.html
if git diff --cached --quiet; then
  echo "No changes to deploy."
  exit 0
fi
git commit -m "${1:-Update dashboard}"
git push
SHA="$(git rev-parse HEAD)"
echo "Pushed ${SHA:0:7}. Waiting for the GitHub Pages build..."

# Poll the Pages build for this commit (needs gh). Fail loudly if the build errors.
if command -v gh >/dev/null 2>&1; then
  for i in $(seq 1 20); do
    read -r status sha err < <(gh api "repos/$REPO/pages/builds/latest" \
      --jq '.status+" "+.commit+" "+((.error.message)//"none")' 2>/dev/null || echo "unknown x none")
    if [ "${sha:0:7}" = "${SHA:0:7}" ]; then
      if [ "$status" = "built" ]; then echo "Build OK. Live at $URL"; exit 0; fi
      if [ "$status" = "errored" ]; then echo "PAGES BUILD FAILED for ${SHA:0:7}: $err" >&2; exit 1; fi
    fi
    sleep 10
  done
  echo "Build still pending after ~3 min; check: gh api repos/$REPO/pages/builds/latest"
else
  echo "Deployed (gh not found, could not verify the build). Live at $URL"
fi
