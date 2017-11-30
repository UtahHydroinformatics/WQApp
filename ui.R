
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

shinyUI(fluidPage(
  # Application title
  titlePanel(strong("Water Quality Analysis")),
  helpText("The purpose of this application is to provide 
           an interactive user interface for analyzing water
           quality data at multiple locations, dates, and
           parameter ranges."),
  
  # Sidebar with user input controls
  sidebarLayout(position = "right",
    sidebarPanel(
           selectInput(inputId="site", 
                       label="1) Select Site:", 
                       choices=unique(buoydata$SiteName), 
                       selected = NULL, 
                       multiple = FALSE,
                       selectize = TRUE, 
                       width = NULL, 
                       size = NULL),
           
           dateRangeInput("dates", label = "2) Select Date Range:",
                          start="2017-04-01"),
           radioButtons(inputId = 'param',
                        label='2) Select Parameter to Plot:',
                        inline= FALSE,
                        choices=list('Temperature'='Temperature_C',
                                     'pH'='pH',
                                     'Dissolved Oxygen'='ODO_mg_L',
                                     'Turbidity' = 'Turbidity_NTU',
                                     'Chlorophyll'='Chlorophyll_ug_L',
                                     'BGA'='BGAPhycocyanin_RFU'),
                        selected=NULL),
           strong("4) Select Parameter Value Range:"),
           sliderInput("Temperature_C", 
                       label = "Temperature",
                       min = -10,
                       max = 30,
                       value = c(0, 10)),
           sliderInput("pH",
                       label = "pH",
                       min = 0,
                       max = 14,
                       value = c(4, 10)),
           sliderInput("ODO_mg_L",
                       label = "DO",
                       min = 0,
                       max = 20,
                       value = c(4, 10))),
           
    # Show outputs, text, etc. in the main panel
  mainPanel(
    img(src="bunny.png", width='50', align ="center"),
    textOutput("selected_var"),
    plotOutput("wqplot"),
    textOutput("modelresults"))
  

)
  )
)
