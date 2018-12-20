library(shiny)
library(ggplot2)
library(dplyr)

dataset <- diamonds

ui <- fluidPage(
    
    title = "Diamonds Explorer",
    
    plotOutput(outputId = 'scatterPlot'),
    
    hr(),
    
    fluidRow(
        column(3,
               h4("Diamonds Explorer"),
               sliderInput('sampleSize', 'Sample Size', 
                           min=1, max=nrow(dataset), value=min(1000, nrow(dataset)), 
                           step=500, round=0),
               br(),
               checkboxInput('jitter', 'Jitter'),
               checkboxInput('smooth', 'Smooth')
        ),
        column(4, offset = 1,
               selectInput('x', 'X', names(dataset)),
               selectInput('y', 'Y', names(dataset), names(dataset)[[7]]),
               selectInput('color', 'Color', c(names(dataset)))
               # selectInput('color', 'Color', c('None', names(dataset)))
        ),
        column(4,
               selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
               selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
        )
    )
)

server <- function(input, output) {
    
    output$scatterPlot <- renderPlot({ 
        # class(c(  select(dataset, input$x) ))
        # print( c(  select(dataset, input$x) ) )
        # qplot(
        #     # x = as.numeric( c(  select(dataset, input$x) ) ) , 
        #     # y = as.numeric( c(  select(dataset, input$y) ) ),
        #     x = c(  select(dataset, input$x) ) , 
        #     y = c(  select(dataset, input$y) ),
        #     # color = c( select(dataset, input$color) ),
        #     main = 'Diamond scatter plot'
        #     )
        ggplot(data = dataset, aes(x = input$x, y = input$y )) + geom_point()  
        } 
        )
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)