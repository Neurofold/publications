#!/usr/bin/bash

echo "SVG to PNG converter - requires rsvg-convert (librsvg2-bin) or inkscape"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SIZE=1000

SVGS=(
  "gsps_v3_edge.svg"
  "gsps_v3_square.svg"
  "gsps_v3_point.svg"
  "gsps_v3_triangle.svg"
)

if command -v rsvg-convert &>/dev/null; then
  echo "Using rsvg-convert"
  for svg in "${SVGS[@]}"; do
    input="$SCRIPT_DIR/$svg"
    output="$SCRIPT_DIR/${svg%.svg}.png"
    echo "Converting $svg -> ${svg%.svg}.png"
    rsvg-convert -w $SIZE -h $SIZE --keep-aspect-ratio "$input" -o "$output"
  done
elif command -v inkscape &>/dev/null; then
  echo "Using inkscape"
  for svg in "${SVGS[@]}"; do
    input="$SCRIPT_DIR/$svg"
    output="$SCRIPT_DIR/${svg%.svg}.png"
    echo "Converting $svg -> ${svg%.svg}.png"
    inkscape --export-type=png --export-filename="$output" -w $SIZE -h $SIZE "$input"
  done
else
  echo "ERROR: neither rsvg-convert nor inkscape found"
  echo "Install with: sudo apt install librsvg2-bin"
  exit 1
fi

echo "Done"
