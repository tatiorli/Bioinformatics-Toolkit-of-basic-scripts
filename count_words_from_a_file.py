# Python Bootcamp - Tatiana Orli Sandberg Raileanu
# 29-10-2021
# Exercise 37: Chapter 9 - Dictionary
# Create a script called count_words_from_a_file.py that given a file with words and spaces and newlines only, count how many times each word appears.

# Initialize variables - dictionary
from collections import defaultdict # You can read about how this module works in detail here: https://www.geeksforgeeks.org/defaultdict-in-python/
import sys

# Warn user to give the input file
if len(sys.argv) > 1:
    filename = sys.argv[1]
    print("Welcome to the word counter program (from a file). The inserted file contains the following words in it:")
else:
    print("Please provide this script with a file to be analyzed.")
    print("Usage: python tatianaorli_count_words_from_a_file.py [inputfile name] \n\n")

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