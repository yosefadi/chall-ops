#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 public_key_file username"
    exit 1
fi

# Assign arguments to variables
public_key_file=$1
username=$2

# Check if the public key file exists
if [ ! -f "$public_key_file" ]; then
    echo "Error: Public key file '$public_key_file' not found."
    exit 1
fi

# Check if the SSH directory exists, create it if not
ssh_dir="/home/$username/.ssh"
if ! ssh -q -o BatchMode=yes "$username@localhost" "[ -d $ssh_dir ]"; then
    echo "Creating SSH directory for user $username..."
    sudo mkdir -p "$ssh_dir"
    sudo chown $username:$username "$ssh_dir"
    sudo chmod 700 "$ssh_dir"
fi

# Read the content of the public key file
public_key_content=$(cat "$public_key_file")

# Check if the public key is already present in authorized_keys
if ssh "$username@localhost" "grep -q \"$public_key_content\" \"$ssh_dir/authorized_keys\""; then
    echo "Public key is already present in ~/.ssh/authorized_keys for user $username."
else
    # Append public key to authorized_keys file
    echo "$public_key_content" | ssh "$username@localhost" "cat >> \"$ssh_dir/authorized_keys\""

    # Check if key was added successfully
    if [ $? -eq 0 ]; then
        echo "Public key added to ~/.ssh/authorized_keys for user $username."
    else
        echo "Error: Failed to add public key to ~/.ssh/authorized_keys for user $username."
    fi
fi
