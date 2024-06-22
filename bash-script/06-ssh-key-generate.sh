#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 destination_directory_path"
    exit 1
fi

# Assign argument to variable
destination_directory=$1

# Check if the destination directory exists, create it if not
if [ ! -d "$destination_directory" ]; then
    mkdir -p "$destination_directory"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create destination directory $destination_directory."
        exit 1
    fi
fi

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f "$destination_directory/id_rsa" -N ""

# Check if key generation was successful
if [ $? -eq 0 ]; then
    echo "SSH key pair generated successfully."
    echo "Private key: $destination_directory/id_rsa"
    echo "Public key: $destination_directory/id_rsa.pub"
else
    echo "Error: SSH key pair generation failed."
    exit 1
fi
