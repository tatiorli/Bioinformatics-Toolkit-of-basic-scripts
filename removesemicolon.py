#!/usr/bin/env python
# Script created with ChatGTP on 09-02-2023 Tatiana Orli Sandberg Raileanu
# Prompt given was: write a python script that input is a multiline file and removes all characters after the first ; until the end of the line 

# Script description:
# The script uses the readlines method to read all the lines of the file into a list. 
# Then, it opens the same file in write mode and writes the lines to it, but this time only up to the first ; character. 
# If there is no ; character in a line, the line is written as is.

def remove_characters(file_name):
    with open(file_name, 'r') as file:
        lines = file.readlines()
    with open(file_name, 'w') as file:
        for line in lines:
            index = line.find(';')
            if index != -1:
                file.write(line[:index] + '\n')
            else:
                file.write(line)

file_name = input("Enter the file name: ")
remove_characters(file_name)