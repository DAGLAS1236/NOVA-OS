#!/usr/bin/env bash
set -euo pipefail

# Create an annotated tag and push to trigger CI if workflows run on tags
# Usage: ./scripts/trigger_ci_by_tag.sh v0.1.0

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <tag>" >&2
  exit 1
fi

TAG=$1

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not inside a git repository." >&2
  exit 1
fi

git tag -a "$TAG" -m "Trigger CI: $TAG"
git push origin "$TAG"

echo "Tag $TAG pushed. Check Actions for workflow run." 
