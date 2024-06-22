#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 ssh_username destination_server_ip"
    exit 1
fi

# Assign arguments to variables
ssh_username=$1
destination_server_ip=$2

# Attempt SSH connection and capture output
ssh_output=$(ssh -q -o BatchMode=yes -o ConnectTimeout=5 "$ssh_username@$destination_server_ip" "echo SSH connection successful.")

# Check SSH connection status
if [ $? -eq 0 ]; then
    echo "SSH connection to $destination_server_ip for user $ssh_username successful."
else
    echo "Failed to SSH connect to $destination_server_ip for user $ssh_username."
fi
