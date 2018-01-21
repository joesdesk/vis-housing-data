library(shiny)
library(ggplot2)
library(tidyverse)
library(stringr)

# Load Data
state_shapes <- read.csv("results/state_shapes.csv", stringsAsFactors = FALSE) %>% 
    select(-statefp)

final_homes <- read.csv("results/final_homes.csv", stringsAsFactors = FALSE) %>% 
    rename(state_name = RegionName)


# Extract fields in final_homes
home_variables <- final_homes %>%
    slice(1) %>%
    gather(variables, del_col, 3:14) %>% 
    pull(variables)


