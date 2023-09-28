#------------------------------------------------------------------------------#
# Proyect title: "Observatorio de Cohesion Social" 
# Author(s): Julio Iturra Sanhueza & Juan Carlos Castillo
# website: https://www.linkedin.com/in/jciturras/
# e-mail: julioiturrasanhueza@gmail.com
#------------------------------------------------------------------------------#
# SERVIDOR LAPOP_Iturra-observatorio-cohesion -----------------------------

# SERVER ------------------------------------------------------------------

function(input, output){

# Efecto collapse en sidebar ------------------------------------------------------------------
  # onevent("mouseenter", "sidebarCollapsed", shinyjs::removeCssClass(selector = "body", class = "sidebar-collapse"))
  # onevent("mouseleave", "sidebarCollapsed", shinyjs::addCssClass(selector = "body", class = "sidebar-collapse"))

  output$longitudinal_plotly <- renderPlotly({
    p <- plot_ly()
    
    # Agregar trazas iniciales (usando la primera variable como predeterminada)
    variable_seleccionada <- unique(df$Variable)[3]
    for(pais in unique(df$País)){
      temp_df <- df %>% filter(País == pais, Variable == variable_seleccionada)
      p <- add_trace(
        p,
        x = temp_df$Ola,
        y = temp_df$Valor,
        name = pais,
        type = 'scatter',
        mode = 'lines',
        line = list(color = sample(colors(), 1)),
        hovertemplate = paste("País: ", pais, 
                              #"<br>Variable: ", variable_seleccionada, 
                              "<br>Ola: %{x}<br>Valor: %{y}<extra></extra>")
      )
    }
    
    # Añadir menú desplegable
    buttons <- lapply(unique(df$Variable), function(variable) {
      list(
        method = 'restyle',
        args = list(
          'y', lapply(unique(df$País), function(pais) {
            df %>% filter(País == pais, Variable == variable) %>% pull(Valor)
          }),
          'hovertemplate', paste("País: %{name}<br>Variable: ", variable, 
                                 "<br>Ola: %{x}<br>Valor: %{y}<extra></extra>")
        ),
        label = variable
      )
    })
    
    # Ajustar el layout para especificar los límites del eje x
    p <- p %>% layout(
      title = "Valores por Ola y País", 
      xaxis = list(range = c(2003, max(df$Ola))),  # Establecer el rango del eje x
      updatemenus = list(list(
        type = 'dropdown',
        x = 0.25,
        y = 1.1,
        buttons = buttons
      ))
    )
    
    return(p)
  }) 
  
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
    
    pal <- colorBin(colorRampPalette(c("#FFFFFF", "#37DF79"))(n = length(bins) - 1), world_data[[variable]], bins = bins)
    
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

### FIN MAPA ----
  noDataMessage <- reactiveVal(FALSE)
  
  observe({
    x_var <- input$x_var
    y_var <- input$y_var
    time_point <- input$Ola
    
    temp_df <- df %>% filter(Ola == time_point)
    
    x_data <- temp_df %>% filter(Variable == x_var, .preserve = TRUE) %>% pull(Valor)
    y_data <- temp_df %>% filter(Variable == y_var, .preserve = TRUE) %>% pull(Valor)
    
    x_available <- nrow(temp_df %>% filter(Variable == x_var, .preserve = TRUE)) > 0 && any(!is.na(x_data))
    y_available <- nrow(temp_df %>% filter(Variable == y_var, .preserve = TRUE)) > 0 && any(!is.na(y_data))
    
    if (x_available && y_available) {
      removeModal()
      noDataMessage(FALSE)
    } else {
      showModal(modalDialog(
        tags$div(tags$h4("Atención"), style = "display: inline-block;"),
        tags$button(tags$i(class = "fa fa-times"), type = "button", class = "close", `data-dismiss` = "modal", 
                    `aria-label` = "Close", style = "margin-left: 15px;"),
        "No hay datos disponibles para la variable en este año. Por favor, seleccione otro.",
        easyClose = TRUE,
        footer = NULL
      ))
      noDataMessage(TRUE)
    }
  })
  
  output$plot <- renderPlotly({
    if (noDataMessage()) return(NULL)
    
    x_var <- input$x_var
    y_var <- input$y_var
    time_point <- input$Ola
    
    temp_df <- df %>% filter(Ola == time_point)
    
    p <- plot_ly()
    for(pais in unique(temp_df$País)){
      x_vals <- temp_df %>% filter(País == pais, Variable == x_var) %>% pull(Valor)
      y_vals <- temp_df %>% filter(País == pais, Variable == y_var) %>% pull(Valor)
      
      image_url <- paste0("png/", pais, ".png")
      
      p <- add_markers(
        p,
        x = x_vals,
        y = y_vals,
        name = pais,
        marker = list(
          symbol = image_url,
          sizemode = "diameter",
          size = 12  # Tamaño de la imagen
        ),
        hovertemplate = paste("País: ", pais,
                              "<br>", x_var, ": %{x}",
                              "<br>", y_var, ": %{y}<extra></extra>")
      )
    }
    
    x_range <- range_values %>% filter(Variable == x_var) %>% select(min_val, max_val) %>% as.numeric()
    y_range <- range_values %>% filter(Variable == y_var) %>% select(min_val, max_val) %>% as.numeric()
    
    p <- p %>% layout(
      title = paste(""),
      xaxis = list(
        title = x_var,
        range = x_range,  # Fijar el rango del eje x
        titlefont = list(
          family = "Arial, sans-serif",
          size = 18,
          color = "black"
        )
      ),
      yaxis = list(
        title = y_var,
        range = y_range,  # Fijar el rango del eje y
        titlefont = list(
          family = "Arial, sans-serif",
          size = 18,
          color = "black"
        )
      ),
      plot_bgcolor = '#ECF0F5',
      paper_bgcolor = '#ECF0F5'
    )
    
    return(p)
  }) 
### FIN Bivariado-----
  # Homepage del sitio web (archivo fuente en .rmd)------------------------------------------------------------
  output$home1 <- renderUI(includeHTML(path = "instrucciones.html"))
  
  # Funcion para mensaje de carga------------------------------------------------------------
  # Simulate work being done for 1 second
  Sys.sleep(1)
  
  # Hide the loading message when the rest of the server function has executed
  hide(id = "loading-content", anim = TRUE, animType = "fade")    
  show("app-content")
}


