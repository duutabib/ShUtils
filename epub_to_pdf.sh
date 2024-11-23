#!/usr/bin/env bash

# Assign second argument as destination 
SEARCH_DIR=${2:-"."}
EXTENSION=${1:-"epub"}

# check directory exits
if [ ! -d "$SEARCH_DIR" ]; then
	echo "Error: $SEARCH_DIR is not valid."
	exit 1
fi

# Get file of type
echo "Searching for $EXTENSION files in $SEARCH_DIR"

CMD='fd -e "$EXTENSION" -t f -p "$SEARCH_DIR"'
echo "running code $CMD..."

search_results=$CMD


# get each entry in results 
for entry in "$search_results"
do
	echo "$entry"
done
