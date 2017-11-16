library(shiny)

ui <- navbarPage("Intervalos para proporciones", fluid = T,
                 tabPanel("Validez",
                          fluidRow(
                            column(4,
                              wellPanel(
                                numericInput('prop', 'Proporción', value = 0.5, step = 0.01, min = 0.01, max = 0.99),
                                numericInput('n', 'Tamaño de muestra', value = 30, step = 1, min = 2),
                                numericInput('a', 'Confianza', value = 0.95, step = 0.005, min = 0.5, max = 0.995)
                              )
                            ),
                            column(8,
                              plotOutput('intervalo')
                            )
                          ),
                          br(),
                          fluidRow(
                            column(4, offset = 4,
                              h4('Limite inferior'),
                              h4('Limite superior'),
                              h4('Longitud del intervalo'),
                              h4('Precisión')
                            ),
                            column(4,
                                   textOutput('li', container = h4),
                                   textOutput('ls', container = h4),
                                   textOutput('longitud', container = h4),
                                   textOutput('precision', container = h4)
                            )
                          )
                 ),
                 tabPanel("Cobertura",
                          fluidRow(
                            column(4,
                                wellPanel(
                                  numericInput('prob', 'Probabilidad', value = 0.5, step = 0.01, min = 0.01, max = 0.99),
                                  numericInput('n2', 'Tamaño de muestra', value = 30, step = 1, min = 2),
                                  numericInput('a2', 'Confianza', value = 0.95, step = 0.005, min = 0.5, max = 0.995),
                                  numericInput('m', 'Número de muestras', value = 250, step = 50, min = 50),
                                  actionButton('nsample', 'Nueva muestra')
                                )
                            ),
                            column(8,
                                   h3('Cobertura'),
                                   textOutput('cobertura', container = h4)
                            )
                          )
                 )
)

