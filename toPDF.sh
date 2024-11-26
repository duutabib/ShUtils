#!/usr/bin/env bash

# Assign second argument as search dir
EXTENSION=${1:-"epub"} 			# default to 'epub' if no extension exist
TARGET_DIR=${2:-"."}			# default to curr dir 
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
echo "Watching for $EXTENSION files in $TARGET_DIR"

# search for files and convert to PDF
fswatch "$TARGET_DIR" -e ".*" -i "\\.$EXTENSION$" | xargs -I '{}' sh -c'
if ebook-convert "$1" "$2/{.}.pdf";then
	echo "$(date): Converted $1 to $2/{.}.pdf" >> "$3";
else
	echo "$(date): Failed to convert $1" >> "$4";
fi' _ {} "$OUTPUT_DIR" "$LOG_FILE" "$ERROR_LOG"

# status statement after completion
echo "Conversion complete. PDFs saved in: $OUTPUT_DIR"
