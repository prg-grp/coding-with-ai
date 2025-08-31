#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./nb2md.sh [SOURCE_DIR=.] [OUTPUT_DIR=md]
# Example:
#   ./nb2md.sh notebooks md

SRC_DIR="${1:-.}"
DEST_DIR="${2:-md}"

# Pick nbconvert command
if command -v jupyter >/dev/null 2>&1; then
  NBCONVERT=(jupyter nbconvert)
elif python3 - <<'PY' >/dev/null 2>&1
import nbconvert
PY
then
  NBCONVERT=(python3 -m nbconvert)
else
  echo "Error: nbconvert not found. Install it with:  python3 -m pip install jupyter nbconvert" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

# Work from source dir so paths are relative
cd "$SRC_DIR"

echo "Converting notebooks from $(pwd) -> $DEST_DIR ..."
converted=0

# Convert all notebooks, preserving tree; skip checkpoint files
while IFS= read -r -d '' nb; do
  rel="${nb#./}"                                 # path relative to SRC_DIR
  outdir="$DEST_DIR/$(dirname "$rel")"           # mirror directory in DEST_DIR
  mkdir -p "$outdir"
  "${NBCONVERT[@]}" --to markdown --output-dir "$outdir" "$nb"
  converted=$((converted+1))
done < <(find . -type f -name '*.ipynb' -not -path '*/.ipynb_checkpoints/*' -print0)

# Rewrite links: .ipynb -> .md  (handles Markdown links and HTML href="")
if [ -d "$DEST_DIR" ]; then
  echo "Rewriting .ipynb links to .md in output tree..."
  find "$DEST_DIR" -type f -name '*.md' -print0 | \
    xargs -0 perl -0777 -pi -e 's/\]\(((?:[^()\\]|\\.)+?)\.ipynb(\#[^)"]+)?\)/]($1.md$2)/g; s/(href="[^"]+)\.ipynb(\#[^"]+)?"/${1}.md${2}"/g'
fi

echo "Done. Converted $converted notebooks into '$DEST_DIR/'."
