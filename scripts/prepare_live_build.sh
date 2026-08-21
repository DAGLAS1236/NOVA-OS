#!/usr/bin/env bash
set -euo pipefail

# Generuje plik package-lists/lubuntu-clone.list.chroot na podstawie
# scripts/packagemanifest

WORKDIR=$(cd "$(dirname "$0")" && pwd)/..
PACK_MANIFEST="$WORKDIR/scripts/packagemanifest"
OUT_DIR="$WORKDIR/config/package-lists"
OUT_FILE="$OUT_DIR/lubuntu-clone.list.chroot"

mkdir -p "$OUT_DIR"

echo "Generuję listę pakietów do $OUT_FILE"

echo "" > "$OUT_FILE"
source "$PACK_MANIFEST"
for p in "${apt_packages[@]}"; do
  echo "$p" >> "$OUT_FILE"
done

echo "Gotowe."
