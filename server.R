
server <- function(input, output) {
  
  
  output$li <- reactive({
    li <- input$prop - qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    round(li, 3)
  })
  
  output$ls <- reactive({
    ls <- input$prop + qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    round(ls, 3)
  })
  
  output$longitud <- reactive({
    li <- input$prop - qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    ls <- input$prop + qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    round(ls - li, 3)
  })
  
  output$precision <- reactive({
    li <- input$prop - qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    ls <- input$prop + qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    longitud <- ls - li
    precision <- 100*max(1 - longitud/input$prop, 0)
    paste0(round(precision,1), '%')
  })
  
  output$intervalo <- renderPlot({
    li <- input$prop - qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    ls <- input$prop + qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    
    par(mar = c(3.1, 1, 1, 1))
    
    
    color_li <- function() ifelse(li >= 0, 'darkcyan', 'red3')
    color_ls <- function() ifelse(ls <= 1, 'darkcyan', 'red3')
    
    plot(0, 0, type = 'n', xlim = c(min(0, li), max(1, ls)), ylim = c(0, 1), axes = F,
         ylab = '', xlab = '', main = '')
    axis(1, seq(round(min(0, li),1), max(1, ls), by = 0.1)); box()
    segments(input$prop, 0, input$prop, 0.75, lwd = 3, lty = 3)
    text(input$prop, 0.75, 'Estimación puntual', pos = 3)
    li <- input$prop - qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    ls <- input$prop + qnorm(0.5+input$a/2)*sqrt(input$prop*(1-input$prop)/input$n)
    segments(li, 0, li, 0.5, lwd = 3, lty = 3, col = color_li())
    text(li, 0.5, 'Límite inferior', pos = 2)
    
    segments(ls, 0, ls, 0.5, lwd = 3, lty = 3, col = color_ls())
    text(ls, 0.5, 'Límite superior', pos = 4)
  })

  output$cobertura <- reactive({
    
    input$nsample
    
    li <- c()
    ls <- c()
    for (i in 1:input$m)
    {
      muestra <- rbinom(input$n2, 1, input$prob)
      prop <- mean(muestra)
      li[i] <- prop - qnorm(0.5+input$a2/2)*sqrt(prop*(1-prop)/input$n2)
      ls[i] <- prop + qnorm(0.5+input$a2/2)*sqrt(prop*(1-prop)/input$n2)
    }
    aux <- (li <= input$prob) & (ls >= input$prob)
    res <- round(100*(sum(aux)/input$m), 1) 
    paste0(res, '%')
  })
  
  
}
