#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 unique_string username"
    exit 1
fi

# Assign arguments to variables
unique_string=$1
username=$2

# SSH directory and authorized_keys path
ssh_dir="/home/$username/.ssh"
authorized_keys="$ssh_dir/authorized_keys"

# Check if the SSH directory and authorized_keys file exist
if ! ssh -q -o BatchMode=yes "$username@localhost" "[ -d $ssh_dir ] && [ -f $authorized_keys ]"; then
    echo "Error: ~/.ssh/authorized_keys not found for user $username."
    exit 1
fi

# Check if the unique_string exists in authorized_keys for the user
if ssh "$username@localhost" "grep -q \"$unique_string\" \"$authorized_keys\""; then
    # Remove the line containing the unique_string using sed
    ssh "$username@localhost" "sed -i '/$unique_string/d' \"$authorized_keys\""
    
    # Check if deletion was successful
    if [ $? -eq 0 ]; then
        echo "Record containing \"$unique_string\" deleted from ~/.ssh/authorized_keys for user $username."
    else
        echo "Error: Failed to delete record containing \"$unique_string\" from ~/.ssh/authorized_keys for user $username."
    fi
else
    echo "Record containing \"$unique_string\" not found in ~/.ssh/authorized_keys for user $username."
fi
