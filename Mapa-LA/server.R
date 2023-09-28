function(input, output, session) {
    # Variable seleccionada (inicialmente "Orgullo nacional")
    selected_variable <- reactiveVal("Orgullo nacional")
    
    # Mapa entre IDs de botones y variables correspondientes
    button_var_map <- list(
        btn_var1 = "Orgullo nacional",
        btn_var2 = "Satisfacción residencial",
        btn_var3 = "Confianza interpersonal",
        btn_var4 = "Comportamiento prosocial",
        btn_var5 = "Confianza en instituciones",
        btn_var6 = "Actitud hacia la democracia",
        btn_var7 = "Participación cívica",
        btn_var8 = "Interés político",
        btn_var9 = "Justicia distributiva",
        btn_var10 = "Surgir en la vida"
    )
    
    # Creación programática de observadores para botones
    lapply(names(button_var_map), function(btn_id) {
        observeEvent(input[[btn_id]], {
            selected_variable(button_var_map[[btn_id]])
        })
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
                "No hay datos disponibles para la combinación de año y variable seleccionada. Por favor, intente con otro año.",
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
                        label = ~paste0(País, ": ", round(data_year[[variable]], 1)),
                        labelOptions = labelOptions(textsize = "17px",
                                                    style = list(
                                                        "font-weight" = "500"
                                                        ))) %>%
            addLegend(pal = pal, values = data_year[[variable]], title = variable) %>%
            setView(lng = -78.4678, lat = -1.8312, zoom = 3)
    })
    
    output$map <- renderLeaflet({
        leaflet(world_data) %>%
            addTiles() %>%
            setView(lng = -78.4678, lat = -1.8312, zoom = 3)
    })

}