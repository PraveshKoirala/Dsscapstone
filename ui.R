library(shiny)
library(shinythemes)


shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(theme=shinytheme("cosmo"),
            
            tags$head(
              tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
            ),
            
    # Give the page a title
    h1("Next word prediction", align="center", 
       style="background-color: grey; color: white; padding-bottom: 5px; padding-top: 5px"),
    
    # Generate a row with a sidebar
    sidebarLayout(
      
      # Define the sidebar with one input
      sidebarPanel( width=5,
        tags$textarea(id="phrase", label="Phrase:", 
                      placeholder = "Enter your phrase here", style="width:100%; height:100px" 
                      ),
        hr(),
        helpText("This product uses Kneser-Ney interpolation to predict next word. Just 
                 enter a phrase and possible next words will be given.")
        
        
      ),
      
      # Create a spot for the barplot
      mainPanel( width=5,
        h3("Possible next words:", style="font-weight: bold; color: #555"),
        h1(textOutput("nextWord1")),
        h2(textOutput("nextWord2")),
        h3(textOutput("nextWord3"))
      )
      
    )
  )
)