library(tidyverse)

directions <- read_file("data/2015_01.txt")

directions %>% 
  str_replace_all("\\(", "1\\,") %>% 
  str_replace_all("\\)", "-1\\,") %>% 
  str_remove("\\,$") %>% 
  str_split("\\,") %>% 
  as_vector() %>% 
  as.numeric() %>% 
  sum()

