# -*- coding: utf-8 -*-
"""
Created on Fri Jun 11 15:34:00 2021

@author: awalter
"""
#%% READ DATA

# Read the txt file in
import pandas as pd
dimensions = pd.read_csv('data/2015_02.txt', sep="\n", header=None)

# Set the name of the only df column
dimensions.columns = ["dims"]

print(dimensions)

#%% PROBLEM 1

# Split the "dims" col into length, width, and depth cols using x as separator
dimensions[["l","w","d"]] = dimensions.dims.str.split("x",expand=True)

# Delete the "dims" col now that the measurements are separate
dimensions.pop("dims")

print(dimensions)

# Make columns for l*w, w*h, and h*l
dimensions["lw"] = pd.to_numeric(dimensions["l"])*pd.to_numeric(dimensions["w"]) 
dimensions["wd"] = pd.to_numeric(dimensions["w"])*pd.to_numeric(dimensions["d"])
dimensions["wl"] = pd.to_numeric(dimensions["d"])*pd.to_numeric(dimensions["l"])

# Delete the l, w, and d cols now that the measurements are multiplied
dimensions.pop("l")
dimensions.pop("w")
dimensions.pop("d")

# Calculate the 2*l*w + 2*w*h + 2*h*l of the gifts
dimensions["tot"] = 2*dimensions["lw"]+2*dimensions["wd"]+2*dimensions["wl"]

# Sum the square footages in the "tot" col
area = sum(dimensions["tot"])

# Calculate the "slack" (area of the smallest side)
# Row-wise minimum of lw, wd, and wl
dimensions['min_side'] = dimensions[["lw","wd","wl"]].min(axis=1)

print(dimensions)

slack = sum(dimensions["min_side"])

# Calculate the answer
answer = area + slack

print(answer)

#%% PROBLEM 2

