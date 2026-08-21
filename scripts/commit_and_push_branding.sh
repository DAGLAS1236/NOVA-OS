#!/usr/bin/env bash
set -euo pipefail

# Commits and pushes branding files to the current git remote
# Usage: ./scripts/commit_and_push_branding.sh [branch]

BRANCH=${1:-$(git rev-parse --abbrev-ref HEAD)}

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git repository. Initialize or run this from the repo root." >&2
  exit 1
fi

echo "Adding branding files..."
git add config/branding/* || true

if git diff --cached --quiet; then
  echo "No branding changes to commit." 
else
  git commit -m "Add/Update Nova OS branding images"
fi

echo "Pushing to remote branch $BRANCH..."
git push origin "$BRANCH"

echo "Done. CI (GitHub Actions) will run if configured." 
