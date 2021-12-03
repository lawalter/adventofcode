library(tidyverse)

diagnostics <- 
  read.fwf(
    "data/2021_03.txt",
    widths = rep(1, 12),
    col.names = paste0("n", as.character(1:12))) %>% 
  as_tibble() 

gamma <- 
  map_chr(
    1:12,
    function(n){
      diagnostics[,n] %>% 
        group_by_all() %>% 
        summarize(sums = n()) %>% 
        ungroup() %>% 
        arrange(desc(sums)) %>% 
        slice(1) %>% 
        select(1) %>% 
        pull()})

gamma <- str_flatten(gamma)

epsilon <- 
  gamma %>% 
  str_replace_all(., "0", "X") %>% 
  str_replace_all(., "1", "0") %>% 
  str_replace_all(., "X", "1")

gnum <- strtoi(gamma, base = 2)
enum <- strtoi(epsilon, base = 2)

gnum*enum



