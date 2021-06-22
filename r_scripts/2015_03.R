library(tidyverse)

raw_directions <- read_file("data/2015_03.txt")

# part 1 ------------------------------------------------------------------

# How many houses receive at least one present?

directions <-
  raw_directions %>% 
  # Pull all of the characters apart
  str_split(pattern = "") %>% 
  unlist() %>% 
  # Put the characters in a tibble
  as_tibble() %>% 
  # Translate the characters into coordinates with numbers
  # > is 1,0
  # < is -1,0
  # ^ is 0,1
  # v is 0,-1
  mutate(
    way_x = 
      case_when(
        value == ">" ~ 1,
        value == "<" ~ -1,
        TRUE ~ 0),
    way_y = 
      case_when(
        value == "^" ~ 1,
        value == "v" ~ -1,
        TRUE ~ 0)) %>% 
  # Set the starting house position
  add_row(
    value = "start",
    way_x = 0,
    way_y = 0,
    .before = 1) %>% 
  # Cumulative sum for each change in direction
  mutate(
    delta_x = cumsum(way_x),
    delta_y = cumsum(way_y),
    # Set each movement/house's coordinates
    coords = 
      paste(delta_x, delta_y, sep = ",") %>% 
      ifelse(str_detect(., "NA"), NA, .))

# Each house = each unique set of coordinates
directions %>% 
  select(coords) %>% 
  filter(!is.na(coords)) %>% 
  distinct() %>% 
  nrow()
  
# part 2 ------------------------------------------------------------------

# Robo-Santa is helping. Every other character is Robo-Santa's move. 
# How many houses receive at least one present?

robo_directions <-
  directions %>% 
  select(-c("way_x":"coords")) %>% 
  # Determine which movement belongs to which gifter
  mutate(
    gifter = 
      ifelse(row_number() %% 2 == 0, "santa", "robo") %>% 
      ifelse(row_number() == 1, NA, .)) %>% 
  # Calculate the movements for each gifter separately
  group_by(gifter) %>% 
  # Do the previous calculation in part 1
  # Translate the characters into coordinates with numbers
  # > is 1,0
  # < is -1,0
  # ^ is 0,1
  # v is 0,-1
  mutate(
    way_x = 
      case_when(
        value == ">" ~ 1,
        value == "<" ~ -1,
        TRUE ~ 0),
    way_y = 
      case_when(
        value == "^" ~ 1,
        value == "v" ~ -1,
        TRUE ~ 0)) %>% 
  # Cumulative sum for each change in direction
  mutate(
    delta_x = cumsum(way_x),
    delta_y = cumsum(way_y),
    # Set each movement/house's coordinates
    coords = 
      paste(delta_x, delta_y, sep = ",") %>% 
      ifelse(str_detect(., "NA"), NA, .)) %>% 
  ungroup()
  
# Each house = each unique set of coordinates
robo_directions %>% 
  select(coords) %>% 
  filter(!is.na(coords)) %>% 
  distinct() %>% 
  nrow()

