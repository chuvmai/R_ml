library(shiny)
library(maps)
library(mapproj)
library(dplyr)
library(fBasics)

source("helpers.R")

# Define UI ----
ui <- fluidPage(
  
  titlePanel("Census"),
  
  fluidRow(
    
    
    
    column(3,
           
           h3("Input"),
           
           hr(),
           
           fileInput(inputId = "file", 
                     label = "File input"
           ),
           
           selectInput(inputId = "choose", label = "Choose a value among:",
                       choices = list("Percent White","Percent Black","Percent Asian", "Percent Hispanic"),
                       selected = "Percent White"
           ),
           
           br(),
           
           sliderInput(
             inputId = "range", label =  "Range of interest",  
             min = 0, max = 100, value = c(10, 90) 
           )
           
    ),
    
    # column(9,
    #        h3("Map of population percentage"),
    #        
    #        hr(),
    #        plotOutput("countyPlot"),
    #        
    #        h3("Data frame"),
    #        hr(),
    #        
    #        tableOutput("counties") 
    # )
    
    column(9,
           
           h3("Output"),
           
           hr(),
           
           tabsetPanel(type = "tabs",
                       
                       tabPanel("County plot", plotOutput("countyPlot")),
                       
                       tabPanel("Scatter plot", 
                                
                                plotOutput("scatterPlot"),
                                
                                br(),
                                
                                plotOutput("scatterPlot2")
                                
                                ),
                       
                       tabPanel("Summary", 
                                
                                tableOutput("summary")
                                # textOutput("summary")
                                # verbatimTextOutput("summary")
                                
                                ),
                       
                       tabPanel("Table", 
                                
                                h4("Head"),
                                
                                tableOutput("countieshead"),
                                
                                h4("Tail"),
                                
                                tableOutput("countiestail")
                                )
           
           )
    )
    
    )
)

# Define server logic ----
server <- function(input, output) {
  
  output$value <- renderText({
    paste("you have chosen ", input$choose )
  })
  
  output$range <- renderText({
    paste("you have chosen a range from ", input$range[1], "to ", input$range[2] )
  })
  
  counties <- reactive({
    
    inFile <- input$file
    
    if (is.null(inFile))
      return(NULL)
    readRDS(inFile$datapath)
    
  })
  
  
  output$countieshead <- renderTable({
    
    req(input$file)
      
    head(counties())
    
  })
  
  output$countiestail <- renderTable({
      
      req(input$file)
      
      tail(counties())
      
  })
  
  output$summary <- renderTable({

      req(input$file)

      return( summary( counties()[,2:6] ) )

  })
  
  # output$summary <- renderPrint({
  # 
  #     req(input$file)
  # 
  #     print( summary( counties()[,2:6] ) )
  # })
  
  
  output$scatterPlot <- renderPlot({
      
      req(input$file)
      
      plot( counties()$white, 
            counties()$black, 
            xlab = "Percent White",
            ylab = "Percent Black",
            xlim = c(0,100),
            ylim = c(0,100),
            # asp = 1,
            main = "White & Black percentage"
            )
      
      
  })
  
  output$scatterPlot2 <- renderPlot({
      
      req(input$file)
      
      plot( counties()$hispanic, 
            counties()$asian, 
            xlab = "Percent Hispanic",
            ylab = "Percent Asian",
            xlim = c(0,100),
            ylim = c(0,100),
            # asp = 1,
            main = "Hispanic & Asian percentage"
      )
      
      
  })
  
  output$countyPlot <- renderPlot({
    
    req(input$file)
    
    data <- switch(input$choose,
                   "Percent White" = counties()$white,
                   "Percent Black" = counties()$black,
                   "Percent Hispanic" = counties()$hispanic,
                   "Percent Asian" = counties()$asian)
    
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

# Run the app
shinyApp(ui = ui, server = server)