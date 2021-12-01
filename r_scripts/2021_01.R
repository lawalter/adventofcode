library(tidyverse)

radar <- read_delim("data/2021_01.txt", delim = "\\\n", col_names = "depth")

radar %>% 
  mutate(delta = ifelse(lag(depth) > depth, "dec", "inc")) %>% 
  filter(delta == "inc") %>% 
  nrow()

# 1527 values are deeper than the previous value

as_tibble(
  map_dbl(
  1:nrow(radar),
  function(n){
    radar$depth[n] + radar$depth[n+1] + radar$depth[n+2]
    })) %>% 
  slice(1:1998) %>% 
  mutate(delta = ifelse(lag(value) < value, "inc", "not")) %>% 
  filter(delta == "inc") %>% 
  nrow()

# 1575