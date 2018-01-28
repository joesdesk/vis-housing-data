ui <- fluidPage(

    titlePanel("Zillow Housing Variable Browser"),

    fluidRow(
        
        sidebarLayout(
            
            sidebarPanel(

                radioButtons("varInput",
                             label = "Variable",
                             choices = sel_variables,
                             selected = "ZHVI_1bedroom")
            ),
            
            mainPanel(
                leafletOutput("map")
                
            )
            
        )
        
    ),
    
    fluidRow(
        
        plotOutput("timseries")
        
    )
    
    
)

# library(rjson)
# rsconnect::deployApp(appDir = 'app', appName = 'vis-housing-data')