server <- function(input, output) {
    
    cartograph_df <- reactive({
        
        # Filter the home data of interest.
        df <- state_homes %>% 
            select(Date, state_name, metric = input$varInput) %>% 
            group_by(state_name) %>%
            arrange(desc(Date)) %>%
            slice(1) %>% 
            right_join(state_boundaries, by = 'state_name') %>% 
            filter_all( all_vars(!is.na(.)) )
        
    })
    
    timeseries_df <- reactive({
        
        # Filter the states of interest.
        clicked_shape <- input$map_shape_click
        state <- clicked_shape[[1]]
        if ( is.null(state) ) {
            state=""
        }
        
        ts <- state_homes %>% 
            mutate( in_selection = state_name==state ) %>% 
            select( Date, metric = input$varInput, in_selection, state_name) %>% 
            mutate(state_name = fct_relevel(state_name, state, after = Inf))
        
    })
    
    output$response <- renderText({
        clicked_shape <- input$map_shape_click
        state <- clicked_shape[[1]]
    })
    
    output$map <- renderLeaflet({
        
        # Extract df
        df <- cartograph_df()
        
        # Create a continuous palette function
        pal <- colorNumeric(
            palette = "Blues",
            domain = df$metric)
        
        # Compute the bounding box
        bbox <- attributes(state_boundaries$geometry)$bbox
        
        leaflet() %>%
            addTiles() %>% 
            addPolygons(color = pal(df$metric), weight = 1, smoothFactor = 0.5,
                        opacity = 1.0, fillOpacity = 0.5,
                        highlightOptions = highlightOptions(color = "white", weight = 1, bringToFront = TRUE),
                        data=df$geometry,
                        layerId=df$state_name) %>% 
            addLegend("bottomright", pal = pal, values = df$metric,
                      title = 'jj',
                      labFormat = labelFormat(prefix = "$"),
                      opacity = 1
            )
    })
    
    output$timseries <- renderPlot({
        
        ts <- timeseries_df()
        
        ts %>% 
            mutate(in_selection = as.factor(in_selection)) %>% 
            ggplot() + 
                aes(x=Date, y=metric, color=in_selection, group=state_name) + 
                geom_line(size=1) + 
                scale_x_date("Year", date_breaks='2 years', date_labels='%Y') + 
                scale_y_continuous(input$varInput)+
                scale_colour_manual(values = c("grey", "blue")) + 
                theme(legend.position="none")
        
    })
    
}