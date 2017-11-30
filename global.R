library(shiny)
buoydata <- read.csv('FormattedBuoyData.csv')
buoydata$DateTime <- as.Date(buoydata$DateTime, format='%m/%d/%Y')
selectInput(inputId="site", 
            label="Site", 
            choices=unique(buoydata$SiteName), 
            selected = NULL, 
            multiple = FALSE,
            selectize = TRUE, 
            width = NULL, 
            size = NULL)
library(ggplot2)

  