#!/bin/bash
# g.joseph, 3 July 2023
#cheap script using the vmstat command (substitute or augment with additional commands)
#looking for processes that always consume memory without going down

# Output directory
output_dir="/path/to/output/directory"

# Base filename
base_filename="memory_usage"

# Get the current timestamp
timestamp=$(date +"%Y%m%d%H%M%S")

# Create a unique filename with timestamp
output_file="${output_dir}/${base_filename}_${timestamp}.log"

# Header for the output file
header="Timestamp    Total    Free   Used   Available"

# Write the header to the output file
echo "$header" > "$output_file"

# Function to manage file versions
manage_file_versions() {
    # Number of maximum file versions to keep
    max_versions=10

    # Get the list of existing files in the output directory matching the base filename pattern
    files=("$output_dir"/"$base_filename"_*.log)

    # Sort the files by modification time in descending order
    sorted_files=($(ls -t "${files[@]}"))

    # Remove excess files if the number of versions exceeds the maximum allowed
    if (( ${#sorted_files[@]} > max_versions )); then
        excess_count=$(( ${#sorted_files[@]} - max_versions ))
        excess_files=("${sorted_files[@]: -$excess_count}")
        rm -f "${excess_files[@]}"
    fi
}

# Infinite loop to continuously take measurements
while true
do
    # Get current timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Get memory usage information using vmstat and extract the relevant columns
    memory_info=$(vmstat -s | awk '/total memory/{total=$1} /free memory/{free=$1} /used memory/{used=$1} /available memory/{available=$1} END{print total, free, used, available}')

    # Write the timestamp and memory usage information to the output file
    echo "$timestamp   $memory_info" >> "$output_file"

    # Run file version management function
    manage_file_versions

    # Sleep for 5 seconds before taking the next measurement
    sleep 5
done
