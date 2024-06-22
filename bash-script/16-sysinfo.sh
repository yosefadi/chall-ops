#!/bin/bash

# Function to get current system time and timezone
get_time_and_timezone() {
    date +"%Y-%m-%d %H:%M:%S %Z"
}

# Function to get Linux kernel version
get_kernel_version() {
    uname -r
}

# Function to get Linux distribution name
get_linux_distro() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        echo "$PRETTY_NAME"
    elif [ -f /etc/lsb-release ]; then
        source /etc/lsb-release
        echo "$DISTRIB_DESCRIPTION"
    else
        echo "Unknown"
    fi
}

# Function to get logged-in users
get_logged_in_users() {
    who | awk '{print $1}' | sort | uniq | paste -sd ', '
}

# Function to count currently logged-in users
count_logged_in_users() {
    who | wc -l
}

# Display system information and logged-in users in a table format
echo "System Information"
echo "------------------"
echo "Hostname: $(hostname)"
echo "Current Time: $(get_time_and_timezone)"
echo "Linux Kernel Version: $(get_kernel_version)"
echo "Linux Distribution: $(get_linux_distro)"
echo ""

echo "Currently logged-in users"
echo "-------------------------"
echo "Users: $(get_logged_in_users)"
echo "Total number of logged-in users: $(count_logged_in_users)"
