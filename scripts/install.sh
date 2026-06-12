#!/usr/bin/env bash
# Install every skill in this repo into ~/.claude/skills/ as a symlink, so
# Claude Code picks them up on the next session start.
#
# Safe to re-run (idempotent). Refuses to clobber an existing real folder or
# a symlink that points somewhere else — pass --force to replace conflicts
# with our symlink.
#
# Usage:
#   ./scripts/install.sh
#   ./scripts/install.sh --force

set -euo pipefail

force=0
for arg in "$@"; do
  case "$arg" in
    -f|--force) force=1 ;;
    -h|--help)
      sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) echo "Unknown flag: $arg" >&2; exit 1 ;;
  esac
done

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_SRC="$REPO_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"

if [[ ! -d "$SKILLS_SRC" ]]; then
  echo "ERROR: $SKILLS_SRC not found. Run this script from inside the cloned repo." >&2
  exit 1
fi

mkdir -p "$SKILLS_DST"

installed=0
already=0
conflicts=()

shopt -s nullglob
for src in "$SKILLS_SRC"/*/; do
  name="$(basename "$src")"
  src_abs="${src%/}"
  dst="$SKILLS_DST/$name"

  if [[ -L "$dst" ]]; then
    current="$(readlink "$dst")"
    if [[ "$current" == "$src_abs" ]]; then
      echo "  ✓ $name (already linked)"
      ((already++))
      continue
    fi
    if (( force )); then
      rm "$dst"
    else
      echo "  ! $name — existing symlink -> $current  (use --force to replace)"
      conflicts+=("$name")
      continue
    fi
  elif [[ -e "$dst" ]]; then
    if (( force )); then
      # Refuse to delete real directories even with --force; too risky.
      echo "  ! $name — real file/dir at $dst (refusing to delete even with --force)"
      conflicts+=("$name")
      continue
    else
      echo "  ! $name — real file/dir already at $dst"
      conflicts+=("$name")
      continue
    fi
  fi

  ln -s "$src_abs" "$dst"
  echo "  + $name"
  ((installed++))
done

echo
echo "Installed: $installed   Already linked: $already   Conflicts: ${#conflicts[@]}"

if (( ${#conflicts[@]} )); then
  echo "Conflicts:"
  for c in "${conflicts[@]}"; do echo "  - $c"; done
  exit 2
fi
