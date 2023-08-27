#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(sf)

load(file = "data/world_data.rdata")

unique_years <- unique(world_data$Ola)
step_size <- unique(diff(unique_years))

function(input, output, session) {
    # Variable seleccionada (inicialmente "Orgullo nacional")
    selected_variable <- reactiveVal("Orgullo nacional")
    
    # Observar los botones de acción y actualizar la variable seleccionada
    observeEvent(input$btn_var1, {
        selected_variable("Orgullo nacional")
    })
    observeEvent(input$btn_var2, {
        selected_variable("Satisfacción residencial")
    })
    observeEvent(input$btn_var3, {
        selected_variable("Confianza interpersonal")
    })
    observeEvent(input$btn_var4, {
        selected_variable("Comportamiento prosocial")
    })
    observeEvent(input$btn_var5, {
        selected_variable("Confianza en instituciones")
    })
    observeEvent(input$btn_var6, {
        selected_variable("Actitud hacia la democracia")
    })
    observeEvent(input$btn_var7, {
        selected_variable("Participación cívica")
    })
    observeEvent(input$btn_var8, {
        selected_variable("Interés político")
    })
    observeEvent(input$btn_var9, {
        selected_variable("Justicia distributiva")
    })
    observeEvent(input$btn_var10, {
        selected_variable("Surgir en la vida")
    })
    
    observe({
        data_year <- world_data %>% filter(Ola == input$Ola)
        variable <- selected_variable()
        
        # Verifica si hay datos para la combinación seleccionada de año y variable
        if (all(is.na(data_year[[variable]]))) {
            leafletProxy("map") %>%
                clearShapes() %>%
                clearControls() %>%
                addTiles() %>%
                setView(lng = -78.4678, lat = -1.8312, zoom = 3)
            
            # Añadir un mensaje modal
            showModal(modalDialog(
                title = "Atención",
                "No hay datos disponibles para la combinación de año y variable seleccionada. Por favor, intente con otra selección.",
                easyClose = TRUE
            ))
            return()
        }
        
        bins <- c(floor(min(world_data[[variable]], na.rm = TRUE)),
                  quantile(world_data[[variable]], probs = seq(0.2, 1, by = 0.2), na.rm = TRUE))
        bins <- unique(round(bins, 1))
        if (length(bins) < 2) {
            bins <- seq(floor(min(world_data[[variable]], na.rm = TRUE)),
                        ceiling(max(world_data[[variable]], na.rm = TRUE)),
                        length.out = 5)
        }
        
        pal <- colorBin(colorRampPalette(c("#E84E4E", "#EEE95F", "#37DF79"))(n = length(bins) - 1), world_data[[variable]], bins = bins)
        
        leafletProxy("map", data = data_year) %>%
            clearShapes() %>%
            clearControls() %>%
            addTiles() %>%
            addPolygons(stroke = FALSE, fillOpacity = 0.5,
                        color = ~pal(data_year[[variable]]),
                        label = ~paste0("País: ", País, "<br>",
                                        variable, ": ", round(data_year[[variable]], 1))) %>%
            addLegend(pal = pal, values = data_year[[variable]], title = variable) %>%
            setView(lng = -78.4678, lat = -1.8312, zoom = 3)
    })
    
    output$map <- renderLeaflet({
        leaflet(world_data) %>%
            addTiles() %>%
            setView(lng = -78.4678, lat = -1.8312, zoom = 3)
    })
}
