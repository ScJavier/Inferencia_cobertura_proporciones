library(shiny)

ui <- fluidPage(

  titlePanel('Intervalos de confianza para proporciones'),
  
  sidebarLayout(
    
    sidebarPanel(title = 'Caption',
      numericInput('prop', 'Proporción', value = 0.5, step = 0.01, min = 0.01, max = 0.99),
      numericInput('n', 'Tamaño de muestra', value = 30, step = 1, min = 2),
      numericInput('a', 'Confianza', value = 0.95, step = 0.005, min = 0.5, max = 0.995)
    ),
    
    mainPanel(
      plotOutput('intervalo'),
      br(),
      h4('Limite inferior'),
      textOutput('li'),
      h4('Limite superior'),
      textOutput('ls'),
      h4('Longitud del intervalo'),
      textOutput('longitud'),
      h4('Precisión'),
      textOutput('precision')
    )
  )
)