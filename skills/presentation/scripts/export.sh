#!/usr/bin/env bash
# export.sh — Render a Frontend Slides HTML file to PNG + PPTX siblings.
#
# Usage:
#   bash export.sh <path-to-html>
#
# Outputs (next to the input HTML, sharing its basename):
#   - <name>.png   retina screenshot of slide 1 at 1920×1080
#   - <name>.pptx  single-slide 16:9 PowerPoint, PNG embedded full-bleed
#
# Requires: node (for Playwright), python3 (for python-pptx). Both
# Playwright and python-pptx are installed on first run if missing.
set -euo pipefail

HTML="${1:-}"
if [[ -z "$HTML" || ! -f "$HTML" ]]; then
  echo "usage: bash export.sh <path-to-html>" >&2
  exit 1
fi

HTML="$(cd "$(dirname "$HTML")" && pwd)/$(basename "$HTML")"
BASE="${HTML%.html}"
PNG="${BASE}.png"
PPTX="${BASE}.pptx"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Ensure Playwright is available ---
if ! node -e "require('playwright')" 2>/dev/null; then
  echo "installing playwright (first run only)..."
  npm install --silent --prefix /tmp playwright >/dev/null 2>&1
  NODE_PATH="/tmp/node_modules"
  export NODE_PATH
fi
if [[ ! -d "$HOME/Library/Caches/ms-playwright" ]] && [[ ! -d "$HOME/.cache/ms-playwright" ]]; then
  echo "installing chromium for playwright (first run only)..."
  npx --prefix /tmp playwright install chromium >/dev/null 2>&1
fi
export NODE_PATH="${NODE_PATH:-/tmp/node_modules}"

# --- Ensure python-pptx is available ---
if ! python3 -c "import pptx" 2>/dev/null; then
  echo "installing python-pptx (first run only)..."
  python3 -m pip install --quiet --user python-pptx
fi

# --- Screenshot ---
node "$SCRIPT_DIR/screenshot.mjs" "$HTML" "$PNG"

# --- Wrap in PPTX ---
python3 "$SCRIPT_DIR/build-pptx.py" "$PPTX" "$PNG"

echo ""
echo "  HTML:  $HTML"
echo "  PNG:   $PNG"
echo "  PPTX:  $PPTX"
