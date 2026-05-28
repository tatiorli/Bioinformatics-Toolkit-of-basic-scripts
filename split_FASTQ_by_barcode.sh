#!/bin/bash

# Check if an input file was provided
if [ -z "$1" ]; then
  echo "Usage: $0 input_file.fastq"
  exit 1
fi

# Create an output directory to store the separated files
mkdir -p output_lib1

# Initialize the counter
counter=0

# Read the input file line by line
while read line; do
  # Check if the line starts with "@"
  if [[ $line =~ ^@ ]]; then
    # Get the two digits after "@"
    prefix=${line:1:2}
    # Create a new output file with the prefix
    output_file="output_lib1/$prefix.fastq"
    # Append the current line to the output file
    echo "$line" >> "$output_file"
    # Read the next line and append it to the output file
    read next_line
    echo "$next_line" >> "$output_file"
    read next_line
    echo "$next_line" >> "$output_file"
    read next_line
    echo "$next_line" >> "$output_file"
    # Update the counter
    counter=$((counter+1))
    # Print the current counter value
    printf "\rProcessed %d reads" "$counter"
  fi
done < "$1"

# Print a newline character at the end of the script
echo ""