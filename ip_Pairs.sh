#!/bin/bash

# Set the input file name
input_file="ip_addresses.txt"

# Read in the IP addresses from the input file
ip_addresses=($(cat $input_file))

# Initialize an array to store the pairs
pairs=()

# Iterate through each IP address and compare it to all the other addresses to form a pair
for ((i=0; i<${#ip_addresses[@]}-1; i++))
do
    for ((j=i+1; j<${#ip_addresses[@]}; j++))
    do
        # Check whether the two IP addresses in the pair are equal before adding the pair to the list of valid pairs
        if [[ ${ip_addresses[i]} != ${ip_addresses[j]} ]]; then
            pairs+=("${ip_addresses[i]} ${ip_addresses[j]}")
        fi
    done
done

# Output the pairs
printf '%s\n' "${pairs[@]}"