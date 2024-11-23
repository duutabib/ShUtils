#!/usr/bin/env bash

# Assign second argument as destination 
EXTENSION=${1:-"epub"}
SEARCH_DIR=${2:-"."}
OUTPUT_DIR=${3:-"/tmp"}

# check directory exits
if [ ! -d "$SEARCH_DIR" ]; then
	echo "Error: $SEARCH_DIR is not valid."
	exit 1
fi

# Get file of type
echo "Searching for $EXTENSION files in $SEARCH_DIR"

# search for files and convert to PDF
fd -e "$EXTENSION" -t f -p "$SEARCH_DIR" -x ebook-convert {} "$OUTPUT_DIR/{.}.pdf"

# status statement after completion
echo "Conversion complete. PDFs saved in: $OUTPUT_DIR"
