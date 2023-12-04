#!/bin/bash
# Script that makes backup from specifie folder
# Script version 1.0
# Exit code 0 - script run successfully
# Exit code 1 - the path parameter was not provided, or too many parameters were provided
# Exit code 2 - the folder from which you want to make the backup does not exist
# Exit code 3 - insufficient disk space to make the backup
# Exit code 4 - exceeded allowed resources
# Exit code 5 - failed to archive the data
# Check available disk space before proceeding with the backup
# Display resources (CPU and RAM) used by the script when it finishes
# Check system resources (CPU and RAM) before proceeding with the backup.
# Check if the .tar.gz file was created successfully
# Add a log file to redirect both standar output and standard error

echo "$(date)"
echo "This is a script that backsup files from a specified folder"

# Record the start time
start_time=$(date +%s)

# Check it the number of arguments provided is not equal to 1
if [ "$#" -eq 1 ]; then
        echo "The path you entered is: $1"
else
        echo "Please provide a path that matches the following pattern /path/to/your/folder as an argument when you run the script"
        exit 1
fi

echo " "

folder_path="$1"

# Check if the folder from which you want to make the backup exists
if [ -d "$folder_path" ]; then
        echo "Folder $1 exists."
else
        echo "Folder $1 does not exist."
        exit 2
fi

echo " "

# Check avilable disk space before proceeding with the backup
# -sk display only a total for each specified file in kilobytes
# the check for available space will be done for the current user also in kilobytes
# the checks are done in kilobytes so that they have the same unit of measurement
required_space=$(du -sk "$folder_path" | awk '{print $1}')
available_space=$(df -k --output=avail "$HOME" | tail -n 1 )

if [ "$available_space" -lt "$required_space" ]; then
        echo "Insufficient disk space. Aborting backup."
        exit 3
else
        echo "There is enough disk space to proceed with the backup."
fi

echo " "

# Check system resources (CPU and RAM). Check that the process does not require more than 10%
max_allowed_cpu=10 # Set the maximum allowed CPU usage precentage
max_allowed_ram=10 # Set the maximum allowed RAM usage precentage

# -p $$ - specifies the process ID to be shown. $$ special variable in Bash taht represent the PID of the current shell
cpu_usage=$(ps -p $$ -o %cpu | tail -1)
ram_usage=$(ps -p $$ -o %mem | tail -1)

# printf formats the value of $cpu_usage. The "%.0f" format specifier is used to round the value to the nearest integer.# this is done to ensure that we compare whole numbers
if [ "$(printf "%.0f" "$cpu_usage")" -gt "$max_allowed_cpu" ] || [ "$(printf "%.0f" "$ram_usage")" -gt "$max_allowed_ram" ]; then
        echo "Exceeded allowed resources (CPU and RAM) to run the backup. Aborting."
        exit 4
else
        echo "System resources within allowed limits to proceed with the backup."
fi

echo " "

# Check if the backup folder exists and creating the backup

current_date=`date +%Y_%m_%d`
backup_folder_path="/home/cosmin/Backup/${current_date}_backup/"
archive_filename="$backup_folder_path/archive_$current_date.tar.gz"

if [ -d "$backup_folder_path" ]; then
        echo "Folder $backup_folder_path exists. Backup for $current_date was already created"
else
        echo "Backup folder does not exist. Creating folder $backup_folder_path ..."
        mkdir $backup_folder_path
        echo "Folder $backup_folder_path was created"
        echo " "
        echo "Files from $folder_path will be backedup to $backup_folder_path"
        find $folder_path -type f -exec cp {} $backup_folder_path \;
        find $backup_folder_path -type f -exec mv {} {}.backup \;
        echo "Backup created"
        echo " "
fi

echo " "



# Record the end time
end_time=$(date +%s)

# Calculate the scipt's runtime
runtime=$((end_time - start_time))
echo "Script runtime: $runtime seconds."

echo " "

# Display CPU and RAM usage
echo "CPU Usage: $cpu_usage%"
echo "RAM Usage: $ram_usage%"

exit 0
