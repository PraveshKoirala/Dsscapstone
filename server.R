library(shiny)

source("predict.R")

getPredictions <- function(phrase){
  predictions <- c('', '', '')
  p <- predict(phrase)
  for (i in 1:length(p)){
    predictions[i] <- p[i]
  }
  predictions
}

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Fill in the spot we created for a plot
  vals <- reactive({getPredictions(input$phrase)})
  output$nextWord1 <- renderText(vals()[1])
  output$nextWord2 <- renderText(vals()[2])
  output$nextWord3 <- renderText(vals()[3])
})