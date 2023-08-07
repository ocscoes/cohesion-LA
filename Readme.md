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
    encuesta.\

    Acceso al análisis:\

2.  ELSOC: contiene el trabajo relacionado a la construcción
    de índices a nivel chileno con los datos de ELSOC. El
    archivo \`Indicadores ELSOC.qmd\` contiene la sintaxis
    de análisis de los datos.

    \
    Acceso al análisis:

3.  Web: Contiene el trabajo relacionado a la actualización
    de los datos LAPOP dentro de la plataforma shiny
    incrustada en la web del Observatorio.

Arbol del directorio:

.
├── ELSOC
│   ├── data
│   └── tmp
├── Índices LAPOP
│   ├── Análisis Pre 2021 LAPOP
│   │   └── Analisispre2021_files
│   │       ├── figure-html
│   │       └── libs
│   │           ├── bootstrap
│   │           ├── clipboard
│   │           └── quarto-html
│   ├── data
│   │   ├── LAPOP2021
│   │   ├── Latinobarometro
│   │   ├── WVS
│   │   └── lapop-faltantes
│   └── tmp
└── Web
    ├── OCSVIS-LA
    │   ├── app
    │   │   ├── _extensions
    │   │   │   └── quarto-ext
    │   │   │       └── fancy-text
    │   │   ├── data
    │   │   ├── rsconnect
    │   │   │   └── shinyapps.io
    │   │   │       ├── jandimter
    │   │   │       └── juitsa
    │   │   ├── tmp
    │   │   └── www
    │   │       ├── bib
    │   │       ├── css
    │   │       ├── html
    │   │       └── images
    │   ├── input
    │   │   └── data
    │   │       ├── original
    │   │       │   ├── LAPOP2021
    │   │       │   └── lapop-faltantes
    │   │       └── proc
    │   └── production
    └── web-ocs-coes
        ├── content
        │   ├── blog
        │   └── input
        │       └── data
        │           └── proc
        ├── data
        │   ├── carousel
        │   ├── clients
        │   ├── features
        │   └── testimonials
        ├── layouts
        │   ├── _default
        │   ├── archetypes
        │   ├── docs
        │   ├── page
        │   └── partials
        │       └── widgets
        ├── public
        │   ├── about
        │   ├── app
        │   ├── app-elsoc
        │   ├── blog
        │   │   ├── 01notice
        │   │   ├── 1
        │   │   │   └── 01
        │   │   │       └── 01
        │   │   │           └── migrate-from-jekyll
        │   │   ├── 2015
        │   │   │   ├── 06
        │   │   │   │   └── 24
        │   │   │   │       └── creating-a-new-theme
        │   │   │   ├── 07
        │   │   │   │   └── 23
        │   │   │   │       └── 2015-07-23-r-rmarkdown
        │   │   │   ├── 08
        │   │   │   │   └── 03
        │   │   │   │       └── hugo-is-for-lovers
        │   │   │   ├── 09
        │   │   │   │   └── 17
        │   │   │   │       └── go-is-for-lovers
        │   │   │   └── 10
        │   │   │       └── 02
        │   │   │           └── linked-post
        │   │   ├── 2015-07-23-r-rmarkdown_files
        │   │   │   └── figure-html
        │   │   ├── 2020
        │   │   │   └── 11
        │   │   │       ├── 10
        │   │   │       │   ├── 01notice
        │   │   │       │   └── 02notice
        │   │   │       └── 11
        │   │   │           ├── 01notice
        │   │   │           ├── 02notice
        │   │   │           ├── creating-a-new-theme
        │   │   │           └── linked-post
        │   │   ├── 2021
        │   │   │   └── 09
        │   │   │       ├── 29
        │   │   │       │   ├── 01notice
        │   │   │       │   ├── 02notice
        │   │   │       │   ├── 03notice
        │   │   │       │   └── 04notice
        │   │   │       └── 30
        │   │   │           └── 02notice
        │   │   └── page
        │   │       └── 1
        │   ├── categories
        │   │   ├── lorem
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── page
        │   │   │   └── 1
        │   │   ├── prensa
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── programming
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── pseudo
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── r
        │   │   │   └── page
        │   │   │       └── 1
        │   │   └── starting
        │   │       └── page
        │   │           └── 1
        │   ├── contact
        │   ├── css
        │   ├── doc
        │   ├── doc2
        │   ├── documentacion
        │   │   ├── creating-a-new-theme
        │   │   ├── go-is-for-lovers
        │   │   ├── hugo-is-for-lovers
        │   │   ├── linked-post
        │   │   ├── migrate-from-jekyll
        │   │   └── page
        │   │       └── 1
        │   ├── faq
        │   ├── img
        │   │   ├── banners
        │   │   ├── carousel
        │   │   ├── clients
        │   │   ├── logoscoes
        │   │   └── testimonials
        │   ├── input
        │   │   └── data
        │   │       └── proc
        │   ├── js
        │   ├── links
        │   ├── noticia
        │   │   ├── 01notice
        │   │   ├── 2020
        │   │   │   └── 11
        │   │   │       └── 11
        │   │   │           └── 01notice
        │   │   └── page
        │   │       └── 1
        │   ├── page
        │   │   └── 1
        │   ├── pubs
        │   ├── rmarkdown-libs
        │   │   ├── header-attrs
        │   │   ├── kePrint
        │   │   └── lightable
        │   ├── shiny
        │   ├── tags
        │   │   ├── cohesion-social
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── conferencias
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── go
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── golang
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── hugo
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── internacional
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── ipsum
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── lanzamiento
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── page
        │   │   │   └── 1
        │   │   ├── plot
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── programming
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── r-markdown
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── regression
        │   │   │   └── page
        │   │   │       └── 1
        │   │   ├── theme
        │   │   │   └── page
        │   │   │       └── 1
        │   │   └── visualizador
        │   │       └── page
        │   │           └── 1
        │   └── test
        ├── resources
        │   └── _gen
        │       ├── assets
        │       └── images
        ├── static
        │   ├── blog
        │   │   └── 2015-07-23-r-rmarkdown_files
        │   │       └── figure-html
        │   ├── css
        │   ├── img
        │   │   ├── banners
        │   │   ├── carousel
        │   │   ├── clients
        │   │   ├── logoscoes
        │   │   └── testimonials
        │   └── rmarkdown-libs
        │       ├── header-attrs
        │       ├── kePrint
        │       └── lightable
        └── themes
            └── hugo-universal-theme
                ├── archetypes
                ├── exampleSite
                │   ├── content
                │   │   └── blog
                │   ├── data
                │   │   ├── carousel
                │   │   ├── clients
                │   │   ├── features
                │   │   └── testimonials
                │   └── static
                │       └── img
                │           ├── banners
                │           ├── carousel
                │           ├── clients
                │           └── testimonials
                ├── i18n
                ├── images
                ├── layouts
                │   ├── _default
                │   ├── archetypes
                │   ├── page
                │   └── partials
                │       └── widgets
                └── static
                    ├── css
                    ├── img
                    └── js
