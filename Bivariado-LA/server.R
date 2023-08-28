function(input, output, session) {
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
            )
        )
        
        return(p)
    })
}