# Observatorio Cohesión Social (OCS)

Este repositorio contiene el trabajo de construcción y
actualización de índices de cohesión social a dos niveles de
análisis:

-   **Latinoamérica**: se utilizan datos de LAPOP,
    Latinobarómetro y la World Value Survey.

-   **Chile**: se utilizan datos de la encuesta longituginal
    ELSOC.

Existen tres carpetas en el repositorio:

1.  **Índices LAPOP**: contiene el trabajo relacionado a la
    construcción de índices a nivel latinoamericano. El
    archivo \`Indices.rmc\` contiene la sintaxis principal
    de análisis. Dentro, existe la carpeta 'Análisis Pre
    2021 LAPOP' que contiene un análisis sobre la
    disponibilidad de datos a lo largo de los años en esta
    encuesta, reflejando el problema de ausencia de las
    variables de interés en la última versión de la
    encuesta. [Link acceso al
    análisis](https://ocscoes.github.io/cohesion-LA/IndicesLAPOP/Indices.html).\

2.  ELSOC: contiene el trabajo relacionado a la construcción
    de índices a nivel chileno con los datos de ELSOC. El
    archivo \`Indicadores ELSOC.qmd\` contiene la sintaxis
    de análisis de los datos. [Link de acceso al
    análisis](https://ocscoes.github.io/cohesion-LA/ELSOC/IndicadoresELSOC.html).

3.  Web: Contiene el trabajo relacionado a la actualización
    de los datos LAPOP dentro de la plataforma shiny
    incrustada en la web del Observatorio.

**Arbol del directorio:**

<!--Producido con `tree -d -L 2-->
```         
.
├── Bivariado-LA
│   ├── data
│   ├── rsconnect
│   └── www
├── ELSOC
│   ├── data
│   └── tmp
├── IndicesLAPOP
│   ├── Análisis Pre 2021 LAPOP
│   ├── Iconos
│   ├── Indices_files
│   ├── data
│   ├── tmp
│   └── www
├── Mapa-LA
│   ├── data
│   ├── rsconnect
│   └── www
├── Web
│   ├── OCSVIS-LA
│   └── web-ocs-coes
└── Dashboard
    ├── app
    ├── input
    └── production
```
