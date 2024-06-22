#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 source_file_path username destination_server_ip"
    exit 1
fi

# Assign arguments to variables
source_file=$1
username=$2
destination_ip=$3

# Check if the source file exists
if [ ! -f "$source_file" ]; then
    echo "Error: Source file '$source_file' not found."
    exit 1
fi

# Use rsync to copy the file to the remote server
rsync -avz --progress "$source_file" "$username@$destination_ip:~/"

# Check if rsync command was successful
if [ $? -eq 0 ]; then
    echo "File '$source_file' copied successfully to $username@$destination_ip:~/"
else
    echo "Error: Failed to copy file '$source_file' to $username@$destination_ip."
fi
