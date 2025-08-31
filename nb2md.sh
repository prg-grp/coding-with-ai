#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./nb2md.sh [SOURCE_DIR=.] [OUTPUT_DIR=md]
# Examples:
#   ./nb2md.sh
#   ./nb2md.sh notebooks md

SRC_DIR="${1:-.}"
DEST_DIR="${2:-md}"

SRC_ABS="$(cd "$SRC_DIR" && pwd -P)"
DEST_ABS="$SRC_ABS/$DEST_DIR"

# Pick nbconvert command
if command -v jupyter >/dev/null 2>&1; then
  NBCONVERT=(jupyter nbconvert)
elif python3 - <<'PY' >/dev/null 2>&1
import nbconvert  # noqa: F401
PY
then
  NBCONVERT=(python3 -m nbconvert)
else
  echo "Error: nbconvert not found. Install with:  python3 -m pip install jupyter nbconvert" >&2
  exit 1
fi

mkdir -p "$DEST_ABS"
cd "$SRC_ABS"

echo "Converting notebooks from $SRC_ABS -> $DEST_ABS ..."
converted=0

# Convert all notebooks, preserving tree; skip checkpoints
while IFS= read -r -d '' nb; do
  rel="${nb#./}"                               # path relative to SRC root
  outdir="$DEST_ABS/$(dirname "$rel")"         # mirror directory in DEST
  mkdir -p "$outdir"
  "${NBCONVERT[@]}" --to markdown --output-dir "$outdir" "$nb"
  converted=$((converted+1))
done < <(find . -type f -name '*.ipynb' -not -path '*/.ipynb_checkpoints/*' -print0)

# Pass 1: rewrite inter-notebook links .ipynb -> .md (Markdown + HTML)
echo "Rewriting .ipynb links to .md..."
find "$DEST_ABS" -type f -name '*.md' -print0 | \
  xargs -0 perl -0777 -pi -e '
    s/\]\(((?:[^()\\]|\\.)+?)\.ipynb(\#[^)"]+)?\)/]($1.md$2)/g;
    s/(href="[^"]+)\.ipynb(\#[^"]+)?"/${1}.md${2}"/g;
  '

# Pass 2: fix links to local resources so they still reference original files
# SKIPS .md/.markdown links (keeps ToC and cross-chapter links intact)
fix_md_links() {
  local md="$1"
  python3 - "$md" "$SRC_ABS" "$DEST_ABS" <<'PY'
import os, re, sys, urllib.parse

md_path, src_root, dest_root = sys.argv[1], sys.argv[2], sys.argv[3]
md_path = os.path.abspath(md_path)
md_dir  = os.path.dirname(md_path)

# directory of the md file inside DEST ('' at top-level)
rel_inside_dest = os.path.relpath(md_dir, dest_root)
if rel_inside_dest == os.curdir:
    rel_inside_dest = ""

# original notebook directory inside SRC
nb_dir_in_src = os.path.join(src_root, rel_inside_dest) if rel_inside_dest else src_root

nb_base = os.path.splitext(os.path.basename(md_path))[0]
assets_prefix = nb_base + "_files/"

scheme_re = re.compile(r'^[a-zA-Z][a-zA-Z0-9+.\-]*:')  # http:, https:, data:, mailto:, etc.

def rewrite_url(url: str) -> str:
    if not url or url.startswith('#') or url.startswith('/'):
        return url
    if scheme_re.match(url):
        return url

    parts = urllib.parse.urlsplit(url)
    path = parts.path

    # leave nbconvert-extracted assets alone
    if path.startswith(assets_prefix):
        return url

    # DO NOT touch links to generated docs
    ext = os.path.splitext(path)[1].lower()
    if ext in ('.md', '.markdown'):
        return url

    # resolve as if link lived in the original notebook directory
    resolved = os.path.normpath(os.path.join(nb_dir_in_src, path))

    # Only rewrite if the target actually exists in the source tree
    if not os.path.exists(resolved):
        return url

    # compute new path relative to md file location in DEST
    new_path = os.path.relpath(resolved, start=md_dir)

    rebuilt = urllib.parse.urlunsplit((parts.scheme, parts.netloc, new_path, parts.query, parts.fragment))
    return rebuilt

with open(md_path, 'r', encoding='utf-8') as f:
    text = f.read()

# HTML src/href attributes
def html_attr_repl(m):
    attr, url = m.group('attr'), m.group('url')
    return f'{attr}="{rewrite_url(url)}"'
text = re.sub(r'(?P<attr>\b(?:src|href))="(?P<url>[^"]+)"', html_attr_repl, text)

# Markdown images/links: ![alt](url) and [txt](url "title")
def md_link_repl(m):
    prefix, url, title = m.group('prefix'), m.group('url'), m.group('title') or ''
    return f'{prefix}{rewrite_url(url)}{title})'
text = re.sub(r'(?P<prefix>!\[[^\]]*\]\()(?P<url>[^)\s]+)(?P<title>\s+"[^"]*")?\)', md_link_repl, text)  # images
text = re.sub(r'(?P<prefix>\[[^\]]*\]\()(?P<url>[^)\s]+)(?P<title>\s+"[^"]*")?\)', md_link_repl, text)   # links

with open(md_path, 'w', encoding='utf-8') as f:
    f.write(text)
PY
}

echo "Fixing local resource links (but skipping .md links)..."
while IFS= read -r -d '' md; do
  fix_md_links "$md"
done < <(find "$DEST_ABS" -type f -name '*.md' -print0)

echo "Done. Converted $converted notebooks into '$DEST_DIR/', kept .md links intact, and fixed resource links."
