rm(list=ls())

load("data/lapop_ind_2004to2021.RData")              # transversal
load("data/lapop_count_2004to2021.RData")             # longitudinal
load("data/lapop_count_2004to2021_long-wave.RData")  # longitudinal para bivariado
fraseo<- xlsx::read.xlsx(file = "data/fraseo_preguntas.xlsx",sheetIndex = 1,encoding = "UTF-8")


# save(fraseo,file = "../input/data/original/fraseo_preguntas.Rdata")

logo_file <- "https://github.com/ocscoes/OCS-COES/raw/master/app/www/images/ocs-21.png"
url_ocs   <- "https://ocs-coes.netlify.app/"
library(shiny)
library(tidyverse)
library(sf)
library(leaflet)
library(tidyverse)
library(plotly)
library(shinyjs)


load(file = "data/world_data.rdata")

unique_years <- unique(world_data$Ola)
step_size <- unique(diff(unique_years))

# Bivariado

load(file = "data/base_shiny.rdata")

unique_years_bi <- unique(df$Ola)
step_size_bi <- unique(diff(unique_years))

# Cálculo de los rangos mínimos y máximos para cada variable
range_values <- df %>%
  group_by(Variable) %>%
  summarise(min_val = min(Valor, na.rm = TRUE),
            max_val = max(Valor, na.rm = TRUE))


