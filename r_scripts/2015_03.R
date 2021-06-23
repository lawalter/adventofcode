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

# side project: plot ------------------------------------------------------

library(gganimate)
#2ca02c cooked asparagus green
#d62728 brick red

directions %>% 
  ggplot(aes(x = delta_x, y = delta_y)) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  geom_vline(xintercept = 0, linetype = "dotted") +
  geom_point(color = "#d62728") +
  labs(y = NULL, x = NULL) +
  theme_classic()

santa_track <- 
  directions %>% 
  mutate(movement = row_number()) %>% 
  select(movement, delta_x, delta_y) %>% 
  ggplot(aes(x = delta_x, y = delta_y)) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  geom_vline(xintercept = 0, linetype = "dotted") +
  geom_point(color = "#d62728", alpha = 0.2) +
  labs(y = NULL, x = NULL) +
  theme_classic() +
  transition_manual(frames = movement, cumulative = TRUE)

animate(santa_track, end_pause = 30)

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

# side project: second plot -----------------------------------------------

robo_directions %>% 
  filter(!is.na(gifter)) %>% 
  arrange(gifter) %>% 
  mutate(movement = rep(1:4096, times = 2)) %>% 
  select(movement, gifter, delta_x, delta_y) %>% 
  ggplot(aes(x = delta_x, y = delta_y, color = gifter)) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  geom_vline(xintercept = 0, linetype = "dotted") +
  geom_point(alpha = 0.2) +
  labs(y = NULL, x = NULL) +
  scale_color_manual(values = c("#2ca02c", "#d62728")) +
  theme_classic()

robosanta_track <- 
  robo_directions %>% 
  filter(!is.na(gifter)) %>% 
  arrange(gifter) %>% 
  mutate(movement = rep(1:4096, times = 2)) %>% 
  select(movement, gifter, delta_x, delta_y) %>% 
  ggplot(aes(x = delta_x, y = delta_y, color = gifter)) +
  geom_hline(yintercept = 0, linetype = "dotted") +
  geom_vline(xintercept = 0, linetype = "dotted") +
  geom_point(alpha = 0.2) +
  labs(y = NULL, x = NULL) +
  scale_color_manual(values = c("#2ca02c", "#d62728")) +
  theme_classic() +
  transition_manual(frames = movement, cumulative = TRUE)

animate(santa_track, end_pause = 30)
