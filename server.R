
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

shinyServer(function(input, output) {

  output$selected_var <- renderText({
  paste('Water quality data at',
  input$site,'between',input$dates[1],
  'and',input$dates[2])
  })
  
  output$wqplot <-renderPlot({
  plotdata <- subset(buoydata,SiteName==input$site &
                       DateTime >= input$dates[1] &
                       DateTime <= input$dates[2] &
                       Temperature_C >=input$Temperature_C[1] &
                       Temperature_C <=input$Temperature_C[2] &
                       pH >= input$pH[1] &
                       pH <= input$pH[2]&
                       ODO_mg_L >= input$ODO_mg_L[1]&
                       ODO_mg_L <= input$ODO_mg_L[2]
                     )

    ggplot(data=plotdata,aes(x=plotdata$DateTime,y=plotdata[,input$param])) +
  geom_point(color='red') +
    ylab('Parameter')+
    xlab('Date/Time')+
    ggtitle('Interactive Plot')
}) 
  tempmod <- reactive({
    plotdata <- subset(buoydata,SiteName==input$site &
                         DateTime >= input$dates[1] &
                         DateTime <= input$dates[2])
    mod <- lm(plotdata$Temperature_C~plotdata[,input$param])
    modsummary <- summary(mod)
    return(modsummary)
    })
  output$modelresults <- renderText({
    paste("R-Squared between Temperature and ",input$param," 
          during the selected time frame:",tempmod()$r.squared)
  })
})