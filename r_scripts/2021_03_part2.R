library(tidyverse)
library(magrittr)

diagnostics2 <- 
  read.fwf(
    "data/2021_03.txt",
    widths = rep(1, 12),
    col.names = paste0("n", as.character(1:12))) %>% 
  as_tibble() 

# Oxygen 

ofun <- 
  function(x){
    
    for (i in names(x)){
      
      summary <-
        x %>%
        group_by(x[as.numeric(str_flatten(str_extract_all(i, "[0-9]{1,2}")))]) %>%
        summarize(sums = n()) %>%
        ungroup() %>%
        arrange(desc(sums))
      
      if(nrow(x) > 1){
        if(nrow(summary) > 1){
          if(summary$sums[1] != summary$sums[2]){
            # Filter to most abundant value
            x %<>%
              filter(x[as.numeric(str_flatten(str_extract_all(i, "[0-9]{1,2}")))] == pull(summary[1, 1]))
          }else{
            # If abundance is equal, filter to 1
            x %<>%
              filter(x[as.numeric(str_flatten(str_extract_all(i, "[0-9]{1,2}")))] == "1")
          }
        }else{
          # If summary table only had 1 row, filter to that value
          x %<>%
            filter(x[as.numeric(str_flatten(str_extract_all(i, "[0-9]{1,2}")))] == pull(summary[1, 1]))
        }
      }
    }
    
    if(nrow(x == 1)){
      # If there's only 1 row left in the diagnostics table...
      
      o2 <- 
        x %>%
        unite(., col = "o2", sep = "") %>%
        pull()
      
      return(o2)
    }
  }

# CO2 

co2fun <- 
  function(x){
    
    for (i in names(x)){
      
      summary <-
        x %>%
        group_by(x[as.numeric(str_flatten(str_extract_all(i, "[0-9]{1,2}")))]) %>%
        summarize(sums = n()) %>%
        ungroup() %>%
        arrange(sums)
      
      if(nrow(x) > 1){
        if(nrow(summary) > 1){
          if(summary$sums[1] != summary$sums[2]){
            # Filter to most abundant value
            x %<>%
              filter(x[as.numeric(str_flatten(str_extract_all(i, "[0-9]{1,2}")))] == pull(summary[1, 1]))
          }else{
            # If abundance is equal, filter to 1
            x %<>%
              filter(x[as.numeric(str_flatten(str_extract_all(i, "[0-9]{1,2}")))] == "0")
          }
        }else{
          # If summary table only had 1 row, filter to that value
          x %<>%
            filter(x[as.numeric(str_flatten(str_extract_all(i, "[0-9]{1,2}")))] == pull(summary[1, 1]))
        }
      }
    }
    
    if(nrow(x == 1)){
      # If there's only 1 row left in the diagnostics table...
      
      co2 <- 
        x %>%
        unite(., col = "co2", sep = "") %>%
        pull()
      
      return(co2)
    }
  }

o2 <- ofun(diagnostics2)
co2 <- co2fun(diagnostics2)

o2num <- strtoi(o2, base = 2)
co2num <- strtoi(co2, base = 2)

o2num*co2num

  
