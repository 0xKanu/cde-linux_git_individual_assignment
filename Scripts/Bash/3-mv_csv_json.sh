#!/bin/bash

dir="json_and_CSV"

mkdir -p $dir

# Loop through args
for arg in $@; do
	if [[ "$arg" = "$dir" ]]; then
		echo "Skipping destination directory: $dir"
		continue
	fi
	
	if [[ -d "$arg" ]]; then
		# If the arg is a directory, then loop through its file contents
		for file in "$arg"/*; do
			if [[ "$file" == *.csv || "$file" == *.json ]]; then
				mv "$file" "$dir"
				echo "Moved $file to $dir"
			fi
		done
	elif [[ -f "$arg" ]]; then
		# If the arg is a single file
		if [[ "$arg" == *.csv || "$arg" == *.json ]]; then
			mv "$arg" "$dir"
			echo "Moved $arg to $dir"
		fi
	else
		echo "Skipping $arg (not a file or directory)"
	fi
done
