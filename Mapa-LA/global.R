library(shiny)
library(tidyverse)
library(sf)
library(shiny)
library(leaflet)
library(tidyverse)

load(file = "data/world_data.rdata")

unique_years <- unique(world_data$Ola)
step_size <- unique(diff(unique_years))

