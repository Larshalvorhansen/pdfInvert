#!/usr/bin/env bash

# Usage: ./invert.sh input.pdf output.pdf

set -ex

INPUT="$1"
OUTPUT="$2"

if [[ -z "$INPUT" || -z "$OUTPUT" ]]; then
  echo "Usage: $0 input.pdf output.pdf"
  exit 1
fi

TMP_DIR=$(mktemp -d)
echo "Working in $TMP_DIR"

# Step 1: Convert PDF pages to high-quality PNGs (like screenshots)
magick -density 200 "$INPUT" "$TMP_DIR/page_%03d.jpeg"

# Step 2: Invert each page image
for img in "$TMP_DIR"/page_*.jpeg; do
  magick "$img" -channel RGB -negate "$img"
  echo "Inverting $img"
done

# Step 3: Reassemble into PDF
magick "$TMP_DIR"/page_*.jpeg "$OUTPUT"

# Step 4: Cleanup
rm -rf "$TMP_DIR"

echo "Done. Output written to $OUTPUT"
