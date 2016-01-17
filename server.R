library(shiny)

source("predict.R")

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Fill in the spot we created for a plot
  output$nextWord <- renderText(predict(input$phrase))
})