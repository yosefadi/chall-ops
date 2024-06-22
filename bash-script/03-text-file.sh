#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 directory_path"
    exit 1
fi

# Assign argument to variable
directory_path=$1

# Check if the provided directory exists
if [ ! -d "$directory_path" ]; then
    echo "Error: Directory $directory_path does not exist."
    exit 1
fi

# Find all text files in the directory
text_files=$(find "$directory_path" -maxdepth 1 -type f -name "*.txt")

# Check if there are any text files in the directory
if [ -z "$text_files" ]; then
    echo "No text files found in the directory."
    exit 0
fi

# Print the table header
printf "%-30s %10s %10s %10s\n" "File" "Rows" "Words" "Characters"
printf "%-30s %10s %10s %10s\n" "----" "----" "-----" "----------"

# Loop through each text file and display counts
for file in $text_files
do
    row_count=$(wc -l < "$file")
    word_count=$(wc -w < "$file")
    char_count=$(wc -m < "$file")
    printf "%-30s %10d %10d %10d\n" "$(basename "$file")" "$row_count" "$word_count" "$char_count"
done

