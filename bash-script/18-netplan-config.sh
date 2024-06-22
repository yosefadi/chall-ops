#!/bin/bash

# Define variables for the configuration
IP_ADDRESS="192.168.1.100/24"
GATEWAY="192.168.1.1"
DNS_SERVERS="8.8.8.8 8.8.4.4"

# Disable any existing netplan configuration for eth0
netplan generate
netplan apply

# Configure eth0 with the specified IP address, gateway, and DNS servers
netplan ip set ethernets.eth0 addresses ${IP_ADDRESS}
netplan ip set ethernets.eth0 gateway4 ${GATEWAY}
netplan ip set ethernets.eth0 nameservers.addresses ["${DNS_SERVERS}"]

# Apply the configuration
netplan apply

# Display the configured settings for eth0
echo "eth0 configuration applied:"
ip addr show dev eth0
echo "Default gateway:"
ip route show | grep default
echo "DNS servers:"
systemd-resolve --status | grep 'DNS Servers'
