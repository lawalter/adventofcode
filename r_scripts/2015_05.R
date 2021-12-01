library(tidyverse)

raw_strings <- 
  read_delim("data/2015_05.txt", delim = "\"", col_names = F) %>% 
  rename(strings = 1)

# part 1 ------------------------------------------------------------------

# How many strings are "nice"?

# A nice string is one with all of the following properties:
# 1. It contains at least three vowels (aeiou only), like aei, xazegov, or
# aeiouaeiouaeiou.
# 2. It contains at least one letter that appears twice in a row, like xx,
# abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
# 3. It does not contain the strings ab, cd, pq, or xy, even if they are part of
# one of the other requirements.

raw_strings
  
  