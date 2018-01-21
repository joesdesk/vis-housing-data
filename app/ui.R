ui <- fluidPage(

    titlePanel("Zillow Housing Variable Browser"),

    sidebarLayout(

        sidebarPanel(
            dateRangeInput('dateRange',
                           label = 'Date range input: yyyy-mm-dd',
                           start = '2000-01-01', end = '2017-12-31',
                           min = '2000-01-01'
                           ),
            radioButtons("varInput",
                         label = "Variable",
                         choices = home_variables,
                         selected = "ZHVI_1bedroom")
        ),

        mainPanel(
            plotOutput("map")
        )

    )
)

