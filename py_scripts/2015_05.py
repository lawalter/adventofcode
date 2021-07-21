# -*- coding: utf-8 -*-
"""
Created on Fri Jul 16 08:10:26 2021

@author: awalter
"""

#%% Week 5, part 1

# Libraries
import re

with open('data/2015_05.txt') as f:
    strings = f.read().splitlines() 

# A nice string is one with all of the following properties:

# It contains at least three vowels (aeiou only)
# It contains at least one letter that appears twice in a row
# It does not contain the strings ab, cd, pq, or xy

nice = []

for i in range(len(strings)):
    # Nice if doesn't contain ab, cd, pq, or xy AND contains >= 3 vowels AND has a letter that is repeated 2x in a row
    if not re.search('ab|cd|pq|xy', strings[i]) and re.search(r'[aeiou].*[aeiou].*[aeiou]', strings[i]) and re.search(r'((\w)\2)', strings[i]): 
        nice.append(strings[i])
    else:
        None      
        
print(nice)
print(len(nice))

# Answer 255
    
#%% Week 5, part 2

# Now, a nice string is one with all of the following properties:

# It contains a pair of any two letters that appears at least twice in the string without overlapping
# It contains at least one letter which repeats with exactly one letter between them


nice2 = []

for i in range(len(strings)):
    if re.search(r'', strings[i]) and re.search(r'((\w)\2)', strings[i]): 
        nice2.append(strings[i])
    else:
        None      
        
print(nice2)
print(len(nice2))