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
      xaxis = list(range = c(2003, max(df$Ola)),
                   rangeslider = list(           # Agregar el range slider
                     visible = TRUE
                   )),  # Establecer el rango del eje x
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
    btn_var10 = "Surgir en la vida",
    btn_var11 = "Cohesión horizontal",
    btn_var12 = "Cohesión vertical"
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
    time_point <- input$Ola_bi
    
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
  
  
  get_flag_emoji <- function(country_name) {
    sanitized_country_name <- gsub(" ", "_", country_name)
    
    flag_emojis <- list(
      Argentina          = "\U0001F1E6\U0001F1F7",
      Belize             = "\U0001F1E7\U0001F1FF",
      Bolivia            = "\U0001F1E7\U0001F1F4",
      Brazil             = "\U0001F1E7\U0001F1F7",
      Canada             = "\U0001F1E8\U0001F1E6",
      Chile              = "\U0001F1E8\U0001F1F1",
      Colombia           = "\U0001F1E8\U0001F1F4",
      Costa_Rica         = "\U0001F1E8\U0001F1F7",
      Dominican_Republic = "\U0001F1E9\U0001F1F4",
      Ecuador            = "\U0001F1EA\U0001F1E8",
      El_Salvador        = "\U0001F1F8\U0001F1FB",
      Guatemala          = "\U0001F1EC\U0001F1F9",
      Guyana             = "\U0001F1EC\U0001F1FE",
      Haiti              = "\U0001F1ED\U0001F1F9",
      Honduras           = "\U0001F1ED\U0001F1F3",
      Jamaica            = "\U0001F1EF\U0001F1F2",
      Mexico             = "\U0001F1F2\U0001F1FD",
      Nicaragua          = "\U0001F1F3\U0001F1EE",
      Panama             = "\U0001F1F5\U0001F1E6",
      Paraguay           = "\U0001F1F5\U0001F1FE",
      Peru               = "\U0001F1F5\U0001F1EA",
      "Trinidad_&_Tobago" = "\U0001F1F9\U0001F1F9",
      United_States      = "\U0001F1FA\U0001F1F8",
      Uruguay            = "\U0001F1FA\U0001F1FE",
      Venezuela          = "\U0001F1FB\U0001F1EA"
    )
    
    return(flag_emojis[[sanitized_country_name]])
  }
  
  
  output$plot <- renderPlotly({
    if (noDataMessage()) return(NULL)
    
    x_var <- input$x_var
    y_var <- input$y_var
    time_point <- input$Ola_bi
    show_flags <- input$show_flags  # Aquí se añade el estado del checkbox
    
    temp_df <- df %>% filter(Ola == time_point)
    
    p <- plot_ly()
    for(pais in unique(temp_df$País)){
      print(pais)
      x_vals <- temp_df %>% filter(País == pais, Variable == x_var) %>% pull(Valor)
      y_vals <- temp_df %>% filter(País == pais, Variable == y_var) %>% pull(Valor)
      
      if (show_flags) {
        # Aquí se añade la funcionalidad para mostrar las banderas como emojis
        flag_emoji <- get_flag_emoji(gsub(" ", "_", pais))
        p <- add_text(
          p,
          x = x_vals,
          y = y_vals,
          text = flag_emoji,
          name = pais,
          size = 5,
          hovertemplate = paste("País: ", pais,
                                "<br>", x_var, ": %{x}",
                                "<br>", y_var, ": %{y}<extra></extra>")
        )
        
        p <- p %>% layout(
          font = list(family = "Noto Color Emoji, Open Sans, verdana, arial, sans-serif"),
          legend = list(font = list(family = "Noto Color Emoji, Open Sans, verdana, arial, sans-serif"))
        )
      } else {
        # Aquí está tu código original para mostrar los marcadores
        p <- add_markers(
          p,
          x = x_vals,
          y = y_vals,
          name = pais,
          marker = list(
            sizemode = "diameter",
            size = 12  # Tamaño de la imagen
          ),
          hovertemplate = paste("País: ", pais,
                                "<br>", x_var, ": %{x}",
                                "<br>", y_var, ": %{y}<extra></extra>")
        )
      }
    }
    
    # Adición de título y títulos de ejes
    p <- p %>% layout(
      title = "Análisis bivariado para subdimensiones de cohesión social",
      xaxis = list(title = x_var),
      yaxis = list(title = y_var)
      # plot_bgcolor = '#ECF0F5',  # Cambio de color de fondo
      # paper_bgcolor= '#ECF0F5'  # Cambio de color de fondo
      
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


