#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(tidyverse)

fluidPage(
    tags$style(".row {margin-right: 30%; margin-left: 30%;}"),
    fluidRow(
        column(6, style = "text-align: center;",
               sliderInput("Ola", "Año:", min = min(unique_years), max = max(unique_years), value = min(unique_years), step = step_size)
        ),
        column(6, style = "text-align: center;",
               actionButton("btn_var1", label = HTML('<img src="img/Orgullo nacional.svg" alt="Orgullo nacional" width="30"><span>Orgullo nacional</span>'), value = "Orgullo nacional"),
               actionButton("btn_var2", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial"),
               actionButton("btn_var3", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial"),
               actionButton("btn_var4", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial"),
               actionButton("btn_var5", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial"),
               actionButton("btn_var6", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial"),
               actionButton("btn_var7", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial"),
               actionButton("btn_var8", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial"),
               actionButton("btn_var9", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial"),
               actionButton("btn_var10", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="30"><span>Satisfacción residencial</span>'), value = "Satisfacción residencial")
        )
    ),
    div(style = "display: flex; justify-content: center;",
        leafletOutput("map", height = "800px", width = "66%")
    )
    
)

