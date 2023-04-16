# Python - Tatiana Orli Sandberg Raileanu
# 29-10-2021
# This script expects a given a file with words and spaces and newlines only, it will count how many times each word appears.

# Initialize variables - dictionary
from collections import defaultdict 
import sys

# Warn user to give the input file
if len(sys.argv) > 1:
    filename = sys.argv[1]
    print("Welcome to the word counter program (from a file). The inserted file contains the following words in it:")
else:
    print("Please provide this script with a file to be analyzed.")
    print("Usage: python count_words_from_a_file.py [inputfile name] \n\n")

# Initialize count
count = defaultdict(int)
# Defaultdict is a container like dictionaries present in the module collections. Defaultdict is a sub-class of the dictionary class that returns a dictionary-like object. 
# The functionality of both dictionaries and defualtdict are almost same except for the fact that defualtdict never raises a KeyError. It provides a default value for the key that does not exists.


with open(filename) as filehandle:
    for full_line in filehandle:
        line = full_line.rstrip('\n') # Strip the full line of the inputfile
        line = line.lower() 
        for word in line.split(): # Split the line per word with function split()
            if word == '': # If empty space, ignore.
                continue
            count[word] += 1 # Otherwise count it

# Time to print the resulting dictionary with counts
for key, value in count.items():
    print(key, ':   ', value)

print("\n\nBye!")
exit()
