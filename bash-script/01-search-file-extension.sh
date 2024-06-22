#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 directory_path file_extension"
    exit 1
fi

# Assign arguments to variables
directory_path=$1
file_extension=$2

# Check if the provided directory exists
if [ ! -d "$directory_path" ]; then
    echo "Error: Directory $directory_path does not exist."
    exit 1
fi

# Remove leading dot from file extension if present
file_extension=${file_extension#.}

# Search for files with the specified extension
find "$directory_path" -maxdepth 1 -type f -name "*.$file_extension"
