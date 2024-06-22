#!/bin/bash

# Function to get current date and time in yyyymmddhhMM format
get_timestamp() {
    date +"%Y%m%d%H%M"
}

# Check if script is run as root, otherwise use sudo
if [ "$EUID" -ne 0 ]; then
    echo "Script not run as root. Using sudo for system update."
    sudo_command="sudo"
else
    sudo_command=""
fi

# Determine the package manager based on available commands
if command -v yum &> /dev/null; then
    # CentOS/RHEL
    package_manager="yum"
elif command -v dnf &> /dev/null; then
    # Fedora
    package_manager="dnf"
elif command -v apt-get &> /dev/null; then
    # Debian/Ubuntu
    package_manager="apt-get"
else
    echo "Error: Unsupported distribution or package manager."
    exit 1
fi

# Generate log file name with current timestamp
log_filename="update-system-$(get_timestamp).log"

# Perform system update using the detected package manager
echo "Starting system update with $package_manager..."

# Redirect both stdout and stderr to the log file
if [ "$package_manager" == "apt-get" ]; then
    # Perform apt update and upgrade if using apt
    $sudo_command apt-get update &>> "$log_filename"
    $sudo_command apt-get -y upgrade &>> "$log_filename"
else
    # Perform regular package manager update if using yum or dnf
    $sudo_command "$package_manager" update &>> "$log_filename"
fi

# Check if update command was successful
if [ $? -eq 0 ]; then
    echo "System update completed successfully. Log saved to: $log_filename"
else
    echo "Error: System update failed. Check $log_filename for details."
fi

