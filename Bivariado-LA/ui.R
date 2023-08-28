fluidPage(
    shinyjs::useShinyjs(),
    tags$head(
        tags$script(
            HTML(
                "$(document).ready(function() {
           // Código JavaScript para modificar el HTML del selector.
           // Añadir SVG para 'Actitud hacia la democracia'
           var optionValue = 'Actitud hacia la democracia';
           $('option:contains(' + optionValue + ')').each(function(){
             if ($(this).text() == optionValue) {
               $(this).html('<img src=\"www/img/Actitud hacia la democracia.svg\" style=\"width:20px; height:auto;\"> ' + optionValue);
             }
           });

           // Similarmente, añadir SVG para 'Confianza interpersonal'
           optionValue = 'Confianza interpersonal';
           $('option:contains(' + optionValue + ')').each(function(){
             if ($(this).text() == optionValue) {
               $(this).html('<img src=\"www/img/Confianza interpersonal.svg\" style=\"width:20px; height:auto;\"> ' + optionValue);
             }
           });
           // Añadir más aquí para otras variables
         });"
            )
        )
    ),
    tags$style("
        .main-container { display: flex; justify-content: center; align-items: flex-start; min-width: 800px; height: 800px;}
        .container-fluid { max-width: 1200px;}
        .map-container { width: 67%; }
        .controls-container { width: 32%; align-items: center; height: 800px; padding-top: 0%; padding-left: 3%;}
        .slider-wrapper { display: flex; align-items: center; }
        .slider-title {width: 33%; font-size: 2em; color: #383838; font-weight: 500; letter-spacing: 2px;}
        .shiny-input-container:not(.shiny-input-container-inline) { width: 62%; max-width: 100%;}
        .btn {font-weight: 300; border-radius: 17px; padding: 4px 0px; font-size: 16px; width: 40%; margin: 0px 0px 3% 5%;}
    "),
    
    div(class = "main-container",
        div(class = "map-container",
            plotlyOutput("plot", height = "800px")
            ),
        div(class = "controls-container",
            sliderInput("Ola", "", min = min(unique_years), max = max(unique_years), value = min(unique_years), step = step_size, sep = ""),
            selectInput("x_var", "Variable para el eje X:", choices = unique(df$Variable), selected = "Actitud hacia la democracia"),
            selectInput("y_var", "Cariable para el eje Y:", choices = unique(df$Variable), selected = "Confianza interpersonal"),
            hidden(div(id = "noDataDiv", style = "color: red;", "No hay datos disponibles para la variable en este año. Por favor, seleccione otro."))
        )
    )
)