#!/bin/bash

# Log file path
log_file="cpu_alert.log"

# Function to get timestamp in yyymmddHHMMSS format
get_timestamp() {
    date +'%Y%m%d%H%M%S'
}

# Function to check CPU usage
check_cpu_usage() {
    # Get 1-minute load average using uptime command
    load_avg_1min=$(uptime | awk -F'[a-z]:' '{ print $2 }' | awk -F, '{ print $1 }' | awk '{$1=$1};1')
    
    # Compare with 75%
    if (( $(echo "$load_avg_1min > 0.75" | bc -l) )); then
	echo "$(get_timestamp) CPU usage exceeded 75%: 1-minute load average is $load_avg_1min"
        echo "$(get_timestamp) CPU usage exceeded 75%: 1-minute load average is $load_avg_1min" >> "$log_file"
    fi
}

# Main monitoring loop
echo "Start monitoring CPU usage..."
while true; do
    check_cpu_usage
    sleep 10  # Check every 10 seconds (adjust as needed)
done
