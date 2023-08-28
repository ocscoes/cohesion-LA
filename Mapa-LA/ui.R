library(shiny)
library(leaflet)
library(tidyverse)

fluidPage(
    tags$style("
        .main-container { display: flex; justify-content: center; align-items: flex-start; }
        .container-fluid { max-width: 1200px;}
        .map-container { width: 66%; }
        .controls-container { width: 34%; text-align: right; padding-top: 20px; align-items: center; height: 800px; padding-top: 0%;}
        .slider-wrapper { display: flex; align-items: center; }
        .slider-title {width: 33%; font-size: 2em; color: #383838; font-weight: 500; letter-spacing: 2px;}
        .shiny-input-container:not(.shiny-input-container-inline) { width: 62%; max-width: 100%;}
        .btn {font-weight: 300; border-radius: 17px; padding: 4px 0px; font-size: 16px; width: 40%; margin: 0px 0px 3% 5%;}
    "),
    
    div(class = "main-container",
        div(class = "map-container",
            leafletOutput("map", height = "800px", width = "100%")
        ),
        
        div(class = "controls-container",
        
            div(class = "slider-wrapper",
                div(class = "slider-title", "AÑO:"),
                sliderInput("Ola", "", min = min(unique_years), max = max(unique_years), value = min(unique_years), step = step_size, sep = "")
            ),    
            
        actionButton("btn_var1", label = HTML('<img src="img/Orgullo nacional.svg" alt="Orgullo nacional" width="75"><span><br>Orgullo<br>nacional</span>')),
        actionButton("btn_var2", label = HTML('<img src="img/Satisfacción residencial.svg" alt="Satisfacción residencial" width="75"><span><br>Satisfacción<br>residencial</span>')),
        actionButton("btn_var3", label = HTML('<img src="img/Confianza interpersonal.svg" alt="Confianza interpersonal" width="75"><span><br>Confianza<br>interpersonal</span>')),
        actionButton("btn_var4", label = HTML('<img src="img/Comportamiento prosocial.svg" alt="Comportamiento prosocial" width="75"><span><br>Comportamiento<br>prosocial</span>')),
        actionButton("btn_var5", label = HTML('<img src="img/Confianza en instituciones.svg" alt="Confianza en instituciones" width="75"><span><br>Confianza en<br>instituciones</span>')),  
        actionButton("btn_var6", label = HTML('<img src="img/Actitud hacia la democracia.svg" alt="Actitud hacia la democracia" width="75"><span><br>Actitud hacia<br>la democracia</span>')),
        actionButton("btn_var7", label = HTML('<img src="img/Participación cívica.svg" alt="Participación cívica" width="75"><span><br>Participación<br>cívica</span>')),
        actionButton("btn_var8", label = HTML('<img src="img/Interés político.svg" alt="Interés político" width="75"><span><br>Interés<br>político</span>')),
        actionButton("btn_var9", label = HTML('<img src="img/Justicia distributiva.svg" alt="Justicia distributiva" width="75"><span><br>Justicia<br>distributiva</span>')),
        actionButton("btn_var10", label = HTML('<img src="img/Surgir en la vida.svg" alt="Surgir en la vida" width="75"><span><br>Surgir en<br>la vida</span>'))
    )
),
)
