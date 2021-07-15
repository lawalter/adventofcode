# -*- coding: utf-8 -*-
"""
Created on Wed Jul 14 13:44:02 2021

@author: awalter
"""

#%% Week 4, part 1

import hashlib
import re

key = "iwrupvqb"

digits = list(range(0, 999999, 1))

for i in digits: 
    ore = key + str(i)
    mined = hashlib.md5(ore.encode("utf-8")).hexdigest()
    if re.match('00000', mined):
        print(i)
        break
 
# Above:
    # 1) The 'key' was given in the advent example. 
    # 2) I created 'digits', a range of numbers from 0 to 999999
    # 3) Using a for loop:
        # - Each number in digits is converted to a string, then appended to 
        #   the key, which = object 'ore'
        # - The 'ore' string is fed into the MD5 hash generator, and the
        #   resultant MD5 hash = object 'mined'
        # - An if statement assesses whether the mined hash string has exactly
        #   5 leading zeroes
        # - The if statement returns the first (and therefore lowest, since it
        #   pulls the number from an ascending sequence) number to generate an
        #   MD5 hash with 5 leading zeros
        
# Answer: 346386

#%% Week 4, part 2

# "Now find one that starts with 6 zeros"

# No answer using the above 'digits' object, so first make a bigger sample
more_digits = list(range(0, 99999999, 1))

for i in more_digits: 
    ore = key + str(i)
    mined = hashlib.md5(ore.encode("utf-8")).hexdigest()
    if re.match('000000', mined):
        print(i)
        break
    
# Answer: 9958218