#!/bin/bash

input_file="input.txt"  # Replace with your input file name or path
output_file="output.txt"  # Replace with your desired output file name or path

# Read the input file line by line
while IFS= read -r odd_line; do
    # Read the next line
    read -r even_line
    
    # Check if the even line is empty (end of file)
    if [[ -z "$even_line" ]]; then
        break
    fi
    
    # Write the joined lines to the output file
    echo "${odd_line}${even_line}" >> "$output_file"
done < "$input_file"

echo "Lines joined successfully."
