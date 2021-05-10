#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
## Load libraries
library(shiny)

# Define server logic required to draw square root of time plot
shinyServer(function(input, output) {

    output$sqrtPlot <- renderPlot({
        sqrtDaysInput <- input$sliderSqrtDays
        maxYInput <- input$sliderMaxY
        wellInput <- input$selectWell

        plot.sqrt.time(wellInput, divider = sqrtDaysInput, maxY = maxYInput)[[1]]

    })
    
    output$intersect <- renderText({
        sqrtDaysInput <- input$sliderSqrtDays
        maxYInput <- input$sliderMaxY
        wellInput <- input$selectWell
        
        plot.sqrt.time(wellInput, divider = sqrtDaysInput, maxY = maxYInput)[[2]]
    })
    
    output$slope <- renderText({
        sqrtDaysInput <- input$sliderSqrtDays
        maxYInput <- input$sliderMaxY
        wellInput <- input$selectWell
        
        plot.sqrt.time(wellInput, divider = sqrtDaysInput, maxY = maxYInput)[[3]]
    })

    output$permeability <- renderText({
        sqrtDaysInput <- input$sliderSqrtDays
        wellInput <- input$selectWell
        
        df <- wellDataSummary %>% filter(Lease == wellInput)
        
        d <- df %>% pull(`Spacing (m)`)
        phi <- df %>% pull(Porosity)
        mu <- df %>% pull(`Viscosity (mPa s)`)
        T_elf <- input$sliderSqrtDays^2
        
        permeability(d = d, phi = phi, mu = mu, T_elf = T_elf)
        })
    
    output$fracHalfLength <- renderText({
        sqrtDaysInput <- input$sliderSqrtDays
        maxYInput <- input$sliderMaxY
        wellInput <- input$selectWell
        
        df <- wellDataSummary %>% filter(Lease == wellInput)
       
        T_elf <- input$sliderSqrtDays^2
        m <- plot.sqrt.time(wellInput, divider = sqrtDaysInput, maxY = maxYInput)[[3]]
        l_e <- df %>% pull(`Lateral Length (m)`)
        h <- df %>% pull(`Net Pay (m)`)
        phi <- df %>% pull(Porosity)
        
        frac.half.length(T_elf = T_elf, m = m, l_e = l_e, h = h, phi = phi)
    })
    
})
