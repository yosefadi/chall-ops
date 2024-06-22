#!/bin/bash

# Log file path
log_file="disk_alert.log"

# Function to get timestamp in yyymmddHHMMSS format
get_timestamp() {
    date +'%Y%m%d%H%M%S'
}

# Function to monitor root disk usage
monitor_disk_usage() {
    # Get root partition usage in percentage
    disk_usage=$(df -h / | awk 'NR==2 {print $5}' | cut -d'%' -f1)
    
    # Compare with 80%
    if [ "$disk_usage" -gt 80 ]; then
        timestamp=$(get_timestamp)
        message="Root disk usage exceeded 80%: Current usage is ${disk_usage}%"
        echo "$timestamp $message"
        echo "$timestamp $message" >> "$log_file"
        send_email "$message"
    fi
}

# Function to send email to root user
send_email() {
    # Replace 'root@AXIOO.local' with the actual root user email address
    root_email="root@AXIOO.local"
    subject="Disk Usage Alert"
    echo "$1" | mail -s "$subject" "$root_email"
}

# Main monitoring loop
echo "Start monitoring disk usage..."
while true; do
    monitor_disk_usage
    sleep 60  # Check every 5 minutes (adjust as needed)
done
