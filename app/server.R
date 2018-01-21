server <- function(input, output) {

    final_frame <- reactive({
        
        state_quantity <- final_homes %>% 
            filter(Date >= input$dateRange[1], Date <= input$dateRange[2]) %>% 
            select(Date, state_name, qq = input$varInput) %>% 
            group_by(state_name) %>%
            arrange(desc(Date)) %>%
            top_n(1)
        
        full_frame <- state_shapes %>%
            right_join(state_quantity, by = 'state_name')
    })
    
    output$map <- renderPlot({
        if (is.null(final_frame())) {
            return()
        }
        ggplot(final_frame()) +
            geom_polygon(aes(x=X, y=Y, group=shapeid, fill=qq)) +
            scale_x_continuous("latitude", limits = c(-125,-65)) + 
            scale_y_continuous("longitude", limits = c(25,50) ) + 
            scale_color_discrete('') + 
            guides(fill=FALSE)
    })
    
}