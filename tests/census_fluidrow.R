library(shiny)
library(maps)
library(mapproj)
library(dplyr)

source("helpers.R")

counties <- readRDS("data/counties.rds")

# Define UI ----
ui <- fluidPage(
    
    titlePanel("Census"),
    
    fluidRow(
        
        # plotOutput("countyPlot"),
        
        # hr(),
        
        column(3,
            
            # p("creat a demo. graph"),
            
            # br(),
            h3("This can be altered"),
            
            hr(),
            
            selectInput(inputId = "choose", label = "Choose a value among:",
                        # choices = list("White" = 1,
                        #                "Black" = 2,
                        #                "Asian" = 3,
                        #                "Latino" = 4),
                        choices = list("Percent White","Percent Black","Percent Asian", "Percent Hispanic"),
                        # choices = c( names(counties)[3:6] ),
                        selected = "Percent Black"
            ),
            
            br(),
            
            sliderInput(
                inputId = "range", label =  "Range of interest",  
                min = 0, max = 100, value = c(10, 90) 
            )
            
        ),
        
        column(9,
               h3("Population percentage"),
               hr(),
               
               plotOutput("countyPlot")
               )
        
        # column(3,
        #     sliderInput(
        #         "range", "Range of interest",  
        #         min = 0, max = 100, value = c(10, 80) 
        #     )
        # )
        
    )
)

# Define server logic ----
server <- function(input, output) {
    
    # output$value <- renderText({ 
    #     paste("you have chosen ", input$choose )
    #     })
    # 
    # output$range <- renderText({ 
    #     paste("you have chosen a range from ", input$range[1], "to ", input$range[2] )
    # })
    
    output$countyPlot <- renderPlot({
        
        data <- switch(input$choose, 
                       "Percent White" = counties$white,
                       "Percent Black" = counties$black,
                       "Percent Hispanic" = counties$hispanic,
                       "Percent Asian" = counties$asian)
        
        color <- switch(input$choose, 
                        "Percent White" = "darkgreen",
                        "Percent Black" = "black",
                        "Percent Hispanic" = "darkorange",
                        "Percent Asian" = "darkviolet")
        
        legend <- switch(input$choose, 
                         "Percent White" = "% White",
                         "Percent Black" = "% Black",
                         "Percent Hispanic" = "% Hispanic",
                         "Percent Asian" = "% Asian")
        
        percent_map(data, color, legend, input$range[1], input$range[2])
        
    })
}

# Run the app ----
shinyApp(ui = ui, server = server)