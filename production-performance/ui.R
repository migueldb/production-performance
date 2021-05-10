#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define UI for application that draws a square root of time plot
fluidPage(

    # Application title
    titlePanel("Unconventional Well Production Performance"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            width = 2,
            h3("Calculate Permeability and Fracture Half Lenght from Square Root of Time Plot"),
            tags$ul(
                tags$li("Please click on Documentation tab for more information"),
                tags$li("Please click on Links tab for GitHub repository and paper links")
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                type = "tabs", 
                    tabPanel(
                        "Home",
                        h1("SQUARE ROOT OF TIME PLOT"),
                        fluidRow(
                            column(
                                4, 
                                selectInput("selectWell", "Select the well for analysis", oilWells, selected = "EAGLE")
                                ),
                            column(
                                4,
                                sliderInput("sliderSqrtDays", "Select the end of linear flow", 0, 45, value = 20)
                                ),
                            column(
                                4,
                                sliderInput("sliderMaxY", "Select the max value of Y", 1, 200, value = 5)
                                ),
                        ),
                        plotOutput("sqrtPlot"),
                        fluidRow(
                            column(
                                3,
                                h5("Linear Model Intersect:")
                                ),
                            column(
                                2,
                                textOutput("intersect")
                                ),
                            column(
                                3,
                                offset = 1,
                                h5("Linear Model Slope:")
                                ),
                            column(
                                2,
                                textOutput("slope")
                                ),
                        ),
                        fluidRow(
                            column(
                                3,
                                h5("Calculated Stimulated Reservoir Volume Permeability (mD):")
                                ),
                            column(
                                2,
                                textOutput("permeability")
                                ),
                            column(
                                3,
                                offset = 1,
                                h5("Calculated Effective Half Fracture length (m):")
                                ),
                            column(
                                2,
                                textOutput("fracHalfLength")
                                )
                            )
                        ), 
                    tabPanel(
                        "Documentation",
                        h3("Theory"),
                        p("Hydraulic fracturing is a process applied to unconventional 
                          reservoirs to create artificial fractures conecting the pores
                          where hydrocarbons are stored. The estimation of formation
                          properties such as permeability and effective half fracture
                          length is an importan step in analyzing production performance. 
                          Luo et al., 2016, developed a method to calculate permeability
                          and effective half length using the square root plot of the
                          production."),
                        h3("Methodology"),
                        tags$ol(
                            start = 1,
                            tags$li("Select the well for analysis from the drop-down menu"),
                            tags$li("Select the end of the linear flow using the slider.
                              The idea is to fit the blue line (linear model) as
                              close as possible to straight line formed by the black
                              dots.  This is equivalent to estimate visually the end
                              of linear flow (red line) and pass this value to the
                              model"),
                            tags$li("If necessary adjust the max value of Y using the slider"),
                            tags$li("The estimated values are shown at the bottom of the plot")
                        )
                        
                        ), 
                    tabPanel(
                        "Links",
                        tags$ol(
                            tags$li("Dataset: SPE Data Repository: Data Set: 1, Well Number:
                                    all wells, From URL: "),
                            tags$a(
                                href = "https://www.spe.org/en/industry/data-repository/",
                                "https://www.spe.org/en/industry/data-repository/"
                                ),
                            tags$li("Luo, H., Li, H., Zhang, J. et al. Production
                                    performance analysis of fractured horizontal well
                                    in tight oil reservoir. J Petrol Explor Prod Technol
                                    8, 229–247 (2018). "),
                            tags$a(
                                href = "https://doi.org/10.1007/s13202-017-0339-x",
                                "https://doi.org/10.1007/s13202-017-0339-x"
                                ),
                            tags$li(
                                tags$a(
                                    href = "https://github.com/migueldb/production-performance",
                                    "https://github.com/migueldb/production-performance"
                                )
                            )
                            
                        )
                    )
            )
            
        )
    )
)
