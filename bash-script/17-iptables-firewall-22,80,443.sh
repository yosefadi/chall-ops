#!/bin/bash

ACTION=$1

# Function to apply iptables rules
apply_rules() {
    # Flush existing rules and set default policies
    iptables -F
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT

    # Allow incoming SSH (port 22), HTTP (port 80), and HTTPS (port 443) connections
    iptables -A INPUT -p tcp --dport 22 -j ACCEPT
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT

    # Drop all other incoming connections
    iptables -A INPUT -j DROP

    # Save iptables rules so they persist after reboot
    iptables-save > /etc/iptables/rules.v4

    echo "iptables rules applied:"
    iptables -L -v -n

    echo "iptables rules saved to /etc/iptables/rules.v4"
}

# Function to delete iptables rules
delete_rules() {
    iptables -F
    iptables -X
    iptables -Z
    iptables -P INPUT ACCEPT
    iptables -P OUTPUT ACCEPT
    iptables -P FORWARD ACCEPT

    # Save empty rules to clear any saved rules
    iptables-save > /etc/iptables/rules.v4

    echo "iptables rules deleted."
}

# Check action argument
if [ "$ACTION" == "apply" ]; then
    apply_rules
elif [ "$ACTION" == "delete" ]; then
    delete_rules
else
    echo "Usage: ./iptables_setup.sh <apply | delete>"
    exit 1
fi
