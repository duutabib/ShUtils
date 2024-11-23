#!/usr/bin/env bash

# Assign second argument as search dir
EXTENSION=${1:-"epub"} 			# default to 'epub' if no extension exist
SEARCH_DIR=${2:-"."}			# default to curr dir 
OUTPUT_DIR=${3:-"/tmp"}			# default to tmp dir
LOG_FILE="${OUTPUT_DIR}/conversion.log"
ERROR_LOG="${OUTPUT_DIR}/error.log"

# check directory exits
if [ ! -d "$SEARCH_DIR" ]; then
	echo "Error: $SEARCH_DIR is not valid."
	exit 1
fi

# Initialize log files
echo "Conversion started at $(date)" > "$LOG_FILE"
echo "Conversion errors at $(date)" > "$ERROR_LOG"

# Get file of type
echo "Searching for $EXTENSION files in $SEARCH_DIR"

# search for files and convert to PDF
fd -e "$EXTENSION" -t f -p "$SEARCH_DIR" -x ebook-convert {} "$OUTPUT_DIR/{.}.pdf"

# status statement after completion
echo "Conversion complete. PDFs saved in: $OUTPUT_DIR"
