# Chall

## Bash Scripts
This folder contains collections of bash scripts that I have written for various purposes as follows:
- [**`01-search-file-extension.sh`**]() - This script searches for files with a specific extension in a directory and its subdirectories. (recursive search)
- [**`02-backup-dir-to-targz.sh`**]() - This script creates a backup of a directory and compresses it into a `.tar.gz` file format in the specified directory.
- [**`03-text-file.sh`**]() - This script list all text files in a directory and its subdirectories and counts the number of word, lines, and characters in each file and displays the result in a tabular format.
- [**`04-backup-dir.sh`**]() - This script creates a backup of a directory in the specified directory and rotates the backup files every 7 days.
- [**`05-update-system.sh`**]() - This script updates the system and installs the latest security patches. It also checks for the latest version of the installed packages and updates them. 
- [**`06-ssh-key-generate.sh`**]() - This script generates an SSH key pair and stores it in the specified directory.
- [**`07-copy-ssh-key-to-server`**]() - This script copies the SSH public key to a remote server.
- [**`08-check-ssh-conn.sh`**]() - This script checks the SSH connection to a remote server and displays the status of the connection whether it is successful or not.
- [**`09-copy-ssh-publickey.sh`**]() - This script copies the SSH public key to a specified user on localhost.
- [**`10-check-ssh-conn.sh`**]() - This script checks the SSH connection to a remote server and displays the status of the connection whether it is successful or not.
- [**`10-delete-ssh-key.sh`**]() - This script deletes the SSH key pair from the specified username based on unique string.
- [**`11-service-action.sh`**]() - This script performs actions on a service such as start, stop, restart, and status.
- [**`12-scp-copy-file-to-server.sh`**]() - This script copies a file to a remote server using the `scp` command. 
- [**`13-rsync-copy-file-to-server.sh`**]() - This script copies a file to a remote server using the `rsync` command.
- [**`14-check-cpu-usage.sh`**]() - This script checks the CPU usage of the system and shows warning when the 1-minute load average exceeds 0.75.
- [**`15-check-root-disk-usage.sh`**]() - This script checks the root disk usage of the system and shows warning when the disk usage exceeds 80%.
- [**`16-sysinfo.sh`**]() - This script displays the system information such as hostname, current time, linux kernel version, linux kernel distro, and logged in users.
- [**`17-iptables-firewall-22,80,443.sh`**]() - This script configures the iptables firewall to allow incoming traffic on ports 22, 80, and 443.
- [**`18-netplan-config.sh`**]() - This script configures the ip address, gateway, and dns server using the netplan utility.

## Scripting Data

- [**`dataframe.py`**]() - This python script creates a dataframe from CSV files and clean the data (duplicate transaction id; null value in the transaction id, date, or customer id) then count the amount of transaction in each branch and store the result in a new CSV file. The result can be seen in the results folder.
- [**`scrapping-api.py`**]() - This python script scrapes data from an API and stores the result in a CSV file. It also performs data filtering based on state-province column and stores the filtered data in a new CSV file. The result can be seen in the results folder.

## Thank you!
Best regards, \
[**`@yosefadi`**](https://github.com/yosefadi)