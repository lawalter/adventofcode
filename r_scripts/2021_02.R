library(tidyverse)

# Part 1

directions <- 
  read_delim(
    "data/2021_02.txt", 
    delim = "\\\n", 
    col_names = "X") %>% 
  separate(X, into = c("dir", "value"))

up <-
  directions %>% 
  filter(dir == "up") %>% 
  group_by(dir) %>% 
  summarize(sum = sum(as.numeric(value))) %>%
  pull(sum)

down <- 
  directions %>% 
  filter(dir == "down") %>% 
  group_by(dir) %>% 
  summarize(sum = sum(as.numeric(value))) %>%
  pull(sum)

forward <- 
  directions %>% 
  filter(dir == "forward") %>% 
  group_by(dir) %>% 
  summarize(sum = sum(as.numeric(value))) %>%
  pull(sum)

depth <- down - up

depth*forward


# Part 2

# down X increases your aim by X units.
# up X decreases your aim by X units.
# forward X does two things:
#   It increases your horizontal position by X units.
#   It increases your depth by your aim multiplied by X.

directions2 <- 
  directions %>% 
  mutate(
    aim = 
      case_when(
        dir == "down" ~ as.numeric(value),
        dir == "up" ~ as.numeric(value)*-1,
        TRUE ~ 0
      ),
    aim_sum = 
      cumsum(aim),
    aim_d = 
      ifelse(
        dir == "forward",
        aim_sum*as.numeric(value),
        NA
      )
  )

up <-
  directions2 %>% 
  filter(dir == "up") %>% 
  group_by(dir) %>% 
  summarize(sum = sum(as.numeric(value))) %>%
  pull(sum)

down <- 
  directions2 %>% 
  filter(dir == "down") %>% 
  group_by(dir) %>% 
  summarize(sum = sum(as.numeric(value))) %>%
  pull(sum)

aim_d <- 
  sum(directions2$aim_d, na.rm = T)

forward <- 
  directions2 %>% 
  filter(dir == "forward") %>% 
  group_by(dir) %>% 
  summarize(sum = sum(as.numeric(value))) %>%
  pull(sum)

depth <- aim_d

depth*forward
