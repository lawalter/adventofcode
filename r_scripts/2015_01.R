library(tidyverse)

raw_directions <- read_file("data/2015_01.txt")

# part 1 ------------------------------------------------------------------

directions <-
  raw_directions %>% 
  str_replace_all("\\(", "1\\,") %>% 
  str_replace_all("\\)", "-1\\,") %>% 
  str_remove("\\,$") %>% 
  str_split("\\,") %>% 
  as_vector() %>% 
  as.numeric()

sum(directions)

# part 2 ------------------------------------------------------------------

map_dbl(
  1:7000, 
  ~sum(directions[1:.x])) %>% 
  as_tibble() %>% 
  mutate(floor = row_number()) %>% 
  filter(value < 0) %>% 
  filter(floor == min(floor)) %>% 
  pull(floor)

