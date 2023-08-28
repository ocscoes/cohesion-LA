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
            
            p <- add_trace(
                p,
                x = x_vals,
                y = y_vals,
                name = pais,
                type = 'scatter',
                mode = 'markers',
                marker = list(size = 12, color = sample(colors(), 1)),
                hovertemplate = paste("País: ", pais,
                                      "<br>", x_var, ": %{x}",
                                      "<br>", y_var, ": %{y}<extra></extra>")
            )
        }
        
        p <- p %>% layout(
            title = paste(""),
            xaxis = list(
                title = x_var,
                titlefont = list(
                    family = "Arial, sans-serif",
                    size = 18,
                    color = "black"
                )
            ),
            yaxis = list(
                title = paste0(y_var),
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