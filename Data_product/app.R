library(shiny)
library(tidyverse)
library(stringr)

## Source ngram function
source("ngram.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Text Prediction App"),
    p("This app predicts the next word based on the inpout phrases."),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
                     h2("Instructions:"), 
                     h5("1. Input a word/words in the text box."),
                     h5("2. The predicted next word prints below it in blue."),
                     h5("3. No need to hit enter of submit."),
                     h5("4. A question mark means no prediction, typically due to mis-spelling"),
                     h5("5. Additional tabs show plots of the top ngrams in the dataset"),
                     br(),
                     a("Source Code", href = "https://github.com/Fancy-Xi/Data-science-capstone")
                     ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("predict",
                         textInput("user_input", h3("Your Input:"), 
                                   value = "Your words"),
                         h3("Predicted Next Word:"),
                         h4(em(span(textOutput("ngram_output"), style="color:blue")))),
                
                
            )   
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$ngram_output <- renderText({
        ngrams(input$user_input)
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
