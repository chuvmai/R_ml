library(shiny)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("Title here!"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        position = "left",
        
        # Sidebar panel for inputs ----
        sidebarPanel( 
            
            # h1("sidebar title here"),
            img(src = "shi.png", height = 80, width = 200),
            
            br(),
            
            # Input: Slider for the number of bins ----
            sliderInput(inputId = "bins",
                        label = "Number of bins:",
                        min = 5,
                        max = 50,
                        value = 20
                        )
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel( 
            
            h1('Histogram'),
            
            # h2('level 2 title'),
            
            # strong('bold text'),
            
            # Output: Histogram ----
            plotOutput(outputId = "distPlot"),
            
            h1('PDF'),
            
            # Output: PDF ----
            plotOutput(outputId = "pdfPlot")
            
        )
    )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
    
    # Histogram of the Old Faithful Geyser Data ----
    # with requested number of bins
    # This expression that generates a histogram is wrapped in a call
    # to renderPlot to indicate that:
    #
    # 1. It is "reactive" and therefore should be automatically
    #    re-executed when inputs (input$bins) change
    # 2. Its output type is a plot
    output$distPlot <- renderPlot({
        
        x    <- faithful$waiting
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        hist(x, breaks = bins, col = "#75AADB", border = "red",
             freq = FALSE,
             xlab = "Waiting time to next eruption (in mins)",
             main = "Histogram of waiting times")
        
        lines( 
            density(x),
            lwd = 2,
            col = 'blue'
            )
    })
    
    output$pdfPlot <- renderPlot({
        
        x    <- faithful$eruptions
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        plot(
            density(
                x
                ),
            xlab = "Eruption (in mins)",
            main = "Histogram of eruptions times"
        )
    })
    
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)