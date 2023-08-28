library(shiny)
library(dplyr)
library(plotly)
library(shinyjs)

load(file = "data/base_shiny.rdata")

unique_years <- unique(df$Ola)
step_size <- unique(diff(unique_years))

# Cálculo de los rangos mínimos y máximos para cada variable
range_values <- df %>%
  group_by(Variable) %>%
  summarise(min_val = min(Valor, na.rm = TRUE),
            max_val = max(Valor, na.rm = TRUE))
