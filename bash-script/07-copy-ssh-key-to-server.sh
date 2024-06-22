#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 public_key_file ssh_username destination_server_ip"
    exit 1
fi

# Assign arguments to variables
public_key_file=$1
ssh_username=$2
destination_server_ip=$3

# Check if the public key file exists
if [ ! -f "$public_key_file" ]; then
    echo "Error: Public key file '$public_key_file' not found."
    exit 1
fi

# Copy public key to the server using ssh-copy-id
ssh-copy-id -i "$public_key_file" "$ssh_username@$destination_server_ip"

# Check if ssh-copy-id command was successful
if [ $? -eq 0 ]; then
    echo "Public key copied successfully to $destination_server_ip for user $ssh_username."
else
    echo "Error: Failed to copy public key to $destination_server_ip."
    exit 1
fi
