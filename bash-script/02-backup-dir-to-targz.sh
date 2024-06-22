#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_directory_path destination_file_path"
    exit 1
fi

# Assign arguments to variables
source_directory_path=$1
destination_file_path=$2

# Check if the provided source directory exists
if [ ! -d "$source_directory_path" ]; then
    echo "Error: Source directory $source_directory_path does not exist."
    exit 1
fi

# Add .tar.gz to destination file path if not present
if [[ "$destination_file_path" != *.tar.gz ]]; then
    destination_file_path="$destination_file_path.tar.gz"
fi

# Get the destination directory from the destination file path
destination_dir=$(dirname "$destination_file_path")

# Create the destination directory if it does not exist
if [ ! -d "$destination_dir" ]; then
    mkdir -p "$destination_dir"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create directory $destination_dir."
        exit 1
    fi
fi

# Create a tar.gz backup of the source directory
tar -czf "$destination_file_path" -C "$source_directory_path" .

# Check if the tar command succeeded
if [ $? -eq 0 ]; then
    echo "Backup successful: $destination_file_path"
else
    echo "Error: Backup failed."
    exit 1
fi
