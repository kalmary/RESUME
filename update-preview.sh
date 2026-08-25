#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
input_pdf="$root_dir/main.pdf"
output_dir="$root_dir/assets"

if ! command -v pdftoppm >/dev/null 2>&1; then
    echo "pdftoppm is required." >&2
    exit 1
fi

if [[ ! -f "$input_pdf" ]]; then
    echo "main.pdf not found. Compile main.tex first." >&2
    exit 1
fi

mkdir -p "$output_dir"
find "$output_dir" -maxdepth 1 -type f -name 'resume-page-*.jpg' -delete
pdftoppm -jpeg -jpegopt quality=90 -r 180 "$input_pdf" "$output_dir/resume-page"
