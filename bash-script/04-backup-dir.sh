#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_directory_path destination_directory"
    exit 1
fi

# Function to calculate age of a directory in days
get_directory_age_days() {
    local directory=$1
    local now=$(date +%s)
    local mtime=$(stat -c %Y "$directory")
    local age_seconds=$(( now - mtime ))
    local age_days=$(( age_seconds / 86400 ))  # 86400 seconds in a day
    echo "$age_days"
}

# Assign arguments to variables
source_directory_path=$1
destination_directory=$2

# Check if the provided source directory exists
if [ ! -d "$source_directory_path" ]; then
    echo "Error: Source directory $source_directory_path does not exist."
    exit 1
fi

# Check if the provided destination directory exists, create it if not
if [ ! -d "$destination_directory" ]; then
    mkdir -p "$destination_directory"
    if [ $? -ne 0 ]; then
        echo "Error: Could not create destination directory $destination_directory."
        exit 1
    fi
fi

# Get the current date in yyyymmdd format
current_date=$(date +"%Y%m%d")

# Get the base name of the source directory
source_directory_name=$(basename "$source_directory_path")

# Construct the new directory name
new_directory_name="${current_date}_${source_directory_name}"

# Construct the full path for the new directory in the destination directory
new_directory_path="${destination_directory}/${new_directory_name}"

# Copy the source directory to the new directory path
cp -r "$source_directory_path" "$new_directory_path"

# Check if the copy command succeeded
if [ $? -eq 0 ]; then
    echo "Copy successful: $new_directory_path"
else
    echo "Error: Copy failed."
    exit 1
fi

# Rotation: Delete directories older than 7 days
seven_days_ago=$(date -d '7 days ago' +%s)
for directory in "${destination_directory}"/*; do
    if [ -d "$directory" ]; then
        dir_name=$(basename "$directory")
        if [[ $dir_name =~ ^[0-9]{8}_.*$ ]]; then  # Check if directory name matches the expected format
            dir_date=${dir_name:0:8}  # Extract date part from directory name
            dir_date_seconds=$(date -d "$dir_date" +%s)
            if [ "$dir_date_seconds" -lt "$seven_days_ago" ]; then
                echo "Deleting old backup: $directory"
                rm -rf "$directory"
            fi
        fi
    fi
done

echo "Backup rotation completed."
