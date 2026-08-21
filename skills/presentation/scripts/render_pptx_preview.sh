#!/usr/bin/env bash
# render_pptx_preview.sh -- render every slide of a PPTX to a PNG so you can
# actually LOOK at it before telling the user it's done.
#
# There is no way to preview a PPTX's real layout without rendering it --
# python-pptx cannot render, and eyeballing coordinates/font sizes in the
# source is how overflow and dead-whitespace bugs make it to the user.
# Always run this after every build AND after every edit that touches
# sizing or positioning, not just the first build.
#
# Usage:
#   bash render_pptx_preview.sh <path-to.pptx> [dpi]
#
# Output: <dir>/<basename>-pg-N.png for each slide (150dpi by default --
# plenty to read text and spot overflow/overlap; bump to 220+ if you need
# to inspect fine detail like border widths).
#
# First run installs LibreOffice (headless PPTX->PDF conversion) and
# Poppler (pdftoppm, PDF->PNG) via Homebrew if missing. macOS only as
# written; on Linux swap the brew install lines for your package manager.

set -euo pipefail

PPTX="${1:?Usage: render_pptx_preview.sh <path-to.pptx> [dpi]}"
DPI="${2:-150}"

if [ ! -f "$PPTX" ]; then
  echo "No such file: $PPTX" >&2
  exit 1
fi

if ! command -v soffice >/dev/null 2>&1; then
  echo "Installing LibreOffice (headless PPTX->PDF conversion)..."
  brew install --cask libreoffice
fi

if ! command -v pdftoppm >/dev/null 2>&1; then
  echo "Installing Poppler (pdftoppm, PDF->PNG)..."
  brew install poppler
fi

DIR="$(cd "$(dirname "$PPTX")" && pwd)"
BASE="$(basename "$PPTX" .pptx)"
PDF="$DIR/$BASE.pdf"

soffice --headless --convert-to pdf --outdir "$DIR" "$PPTX" >/dev/null
pdftoppm -png -r "$DPI" "$PDF" "$DIR/$BASE-pg"

echo "Rendered pages:"
ls "$DIR/$BASE-pg"*.png
