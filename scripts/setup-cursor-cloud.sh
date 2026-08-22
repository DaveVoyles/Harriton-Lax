#!/usr/bin/env bash
# Portable Cloud prove: coaching-hub markdown tree is present.
set -euo pipefail

ROOT_DIR="${CURSOR_CLOUD_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"

required_files=(
  "$ROOT_DIR/README.md"
  "$ROOT_DIR/drills/README.md"
  "$ROOT_DIR/offense/README.md"
  "$ROOT_DIR/defense/README.md"
)

required_dirs=(
  "$ROOT_DIR/practice-plans"
  "$ROOT_DIR/game-plans"
  "$ROOT_DIR/plays"
)

for path in "${required_files[@]}"; do
  if [ ! -f "$path" ]; then
    echo "setup-cursor-cloud: missing file $path" >&2
    exit 1
  fi
done

for path in "${required_dirs[@]}"; do
  if [ ! -d "$path" ]; then
    echo "setup-cursor-cloud: missing directory $path" >&2
    exit 1
  fi
  if [ -z "$(find "$path" -type f -name '*.md' -print -quit)" ]; then
    echo "setup-cursor-cloud: no markdown files in $path" >&2
    exit 1
  fi
done

echo "setup-cursor-cloud: coaching hub files ok"
echo "setup-cursor-cloud: environment ready"
