#!/usr/bin/env python
# Script created with ChatGTP on 12-02-2023 Tatiana Orli Sandberg Raileanu
# Prompt given was: python script that gets a multiline file as input and grep each line in another file, captures the result match in an external file

# Usage: You can run the script by passing in the names of the input file, search file, and output file as command line arguments, like this:
# python script.py input.txt search.txt output.txt

import sys

# Define the input and output files
input_file = sys.argv[1]
search_file = sys.argv[2]
output_file = sys.argv[3]

# Open the input file and read its contents
with open(input_file, 'r') as f:
    input_lines = f.read().splitlines()

# Open the search file and read its contents
with open(search_file, 'r') as f:
    search_lines = f.read().splitlines()

# Initialize an empty list to store the matching lines
matching_lines = []

# Loop through each line in the input file
for line in input_lines:
    # Loop through each line in the search file
    for search_line in search_lines:
        # Check if the line from the input file is in the search file
        if line in search_line:
            # If a match is found, add the line from the input file to the list of matching lines
            matching_lines.append(search_line)

# Open the output file for writing
with open(output_file, 'w') as f:
    # Write each line in the list of matching lines to the output file
    for line in matching_lines:
        f.write(line + '\n')
        