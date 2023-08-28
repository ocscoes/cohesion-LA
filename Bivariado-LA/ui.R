fluidPage(
    useShinyjs(),
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
    selectInput("x_var", "Seleccione la variable para el eje X:", choices = unique(df$Variable), selected = "Actitud hacia la democracia"),
    selectInput("y_var", "Seleccione la variable para el eje Y:", choices = unique(df$Variable), selected = "Confianza interpersonal"),
    sliderInput("Ola", "", min = min(unique_years), max = max(unique_years), value = min(unique_years), step = step_size, sep = ""),
    plotlyOutput("plot"),
    hidden(div(id = "noDataDiv", style = "color: red;", "No hay datos disponibles para la variable en este año. Por favor, seleccione otro."))
)