#!/bin/bash

# Function to check if running as root
check_root() {
    if [ "$(id -u)" -eq 0 ]; then
        return 0  # Running as root
    else
        return 1  # Not running as root
    fi
}

# Check if the correct number of arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 service_name action"
    exit 1
fi

# Assign arguments to variables
service_name=$1
action=$2

# Function to check if systemd is in use
check_systemd() {
    if command -v systemctl >/dev/null 2>&1; then
        return 0  # Systemd is available
    else
        return 1  # Systemd is not available
    fi
}

# Function to check if init.d is in use
check_initd() {
    if command -v service >/dev/null 2>&1; then
        return 0  # Init.d is available
    else
        return 1  # Init.d is not available
    fi
}

# Check if running as root
if ! check_root; then
    echo "Error: This script must be run as root."
    exit 1
fi

# Determine which service manager to use
if check_systemd; then
    # Systemd is detected, perform action using systemctl
    case "$action" in
        start)
            systemctl start "$service_name"
            ;;
        stop)
            systemctl stop "$service_name"
            ;;
        status)
            systemctl status "$service_name"
            ;;
        *)
            echo "Error: Unsupported action. Supported actions: start, stop, status."
            exit 1
            ;;
    esac
elif check_initd; then
    # Init.d is detected, perform action using service
    case "$action" in
        start)
            service "$service_name" start
            ;;
        stop)
            service "$service_name" stop
            ;;
        status)
            service "$service_name" status
            ;;
        *)
            echo "Error: Unsupported action. Supported actions: start, stop, status."
            exit 1
            ;;
    esac
else
    echo "Error: Unsupported init system. Neither systemctl nor service commands found."
    exit 1
fi
