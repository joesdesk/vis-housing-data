library(shiny)

# For analysis and plotting
library(tidyverse)
library(lubridate)
library(stringr)

# Data for the boundaries and plotting
library(leaflet)
library(sf)
library(USAboundaries)

#
library(RColorBrewer)


# Import map data
state_boundaries <- us_states(resolution = 'low') %>% 
    select(state_name, geometry) %>% 
    mutate(state_name = str_replace_all(state_name, fixed(" "), ""))

# These can't work without USAboundariesData which can't be
# loaded with shinyapps
#county_boundaries <- us_counties(resolution = 'low')
#zipcode_boundaries <- us_zipcodes()
#cities_boundaries <- us_cities()

# Import housing data
state_homes <- read.csv("final_homes.csv", stringsAsFactors = FALSE) %>% 
    mutate(Date = date(Date), state_name=as.factor(state_name))


# Declare the choices of resolution
resolutions = c("Continental", "State", "County", "City")

# Choices of varaibles
sel_variables <- state_homes %>% 
    filter(state_name!='UnitedStates') %>% 
    summarize_all( funs( sum(is.na(.)) ) ) %>% 
    gather(variable, na_count) %>% 
    arrange(na_count) %>% 
    slice(3:14) %>% 
    pull(variable)