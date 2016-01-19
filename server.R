library(shiny)

source("predict.R")

getPredictions <- function(phrase){
  predictions <- predict(phrase)
  predictions[is.na(predictions)] <- ""
  predictions
}

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Fill in the spot we created for a plot
  vals <- reactive({getPredictions(input$phrase)})
  print(vals)
  output$nextWord1 <- renderText(vals()[1])
  output$nextWord2 <- renderText(vals()[2])
  output$nextWord3 <- renderText(vals()[3])
})