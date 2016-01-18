library(shiny)



shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Next word prediction"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        tags$textarea(id="phrase", label="Phrase:", 
                      placeholder = "Enter your phrase here", rows=5, cols=50),
        hr(),
        helpText("This product uses Kneser-Ney interpolation to predict next word. Just 
                 enter a phrase and possible next words will be given.")
        
        
      ),
      
      # Create a spot for the barplot
      mainPanel(
        h3("Possible next words:"),
        h1(textOutput("nextWord"))
      )
      
    )
  )
)