library(shiny)
library(tidyverse)
library(stringr)

## Source ngram function
source("ngram.R")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Text Prediction Application"),
    p("This app predicts the next word based on the input phrases."),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
                     h2("Summary"), 
                     h5("* Input a word/words in the text box below."),
                     h5("* The machine will tell you the next word."),
                     h5("* When there's no model prediction, a question mark will show up."),
                     h5("* The other tabs show the most frequent words predicted using unigram, bigram, and trigram"),
                     br(),
                     a("Source Code", href = "https://github.com/Fancy-Xi/Data-science-capstone")
                     ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("Prediction",
                         textInput("user_input", h3("What are you thinking"), 
                                   value = "Your words"),
                         h3("Predicted Next Word:"),
                         h4(em(span(textOutput("ngram_output"), style="color:pink")))),
                tabPanel("Unigram - Most common 20 words",
                         br(),
                         img(src = "unigram2.png", height = 500, width = 700)),
                
                tabPanel("Bigram - Most common 20 words",
                         br(),       
                         img(src = "biigram2.png", height = 500, width = 700)),
                
                tabPanel("Trigram - Most common 20 wordss",
                         br(),
                         img(src = "trigram2.png", height = 500, width = 700))
                
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
