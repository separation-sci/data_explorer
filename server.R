# Define server logic required to draw a histogram ----
server = function(input, output) {
  
  observeEvent(input$folders,
               {
                 updateSelectInput(
                   session = getDefaultReactiveDomain(),
                   input = "files",
                   choices = meta_data$flnm[dirname(meta_data$flnm) %in% input$folders] %>% basename()
                 )
               })
  
  output$graphs = renderPlot({
    plot_data = 0
    plot_data = raw_data[basename(raw_data$flnm) %in% input$files, ]
    
    plot(
      plot_data$time,
      plot_data$RFU,
      type = "l",
      xlab = "time",
      ylab = "RFU",
      xlim = input$x_axis,
      ylim = input$y_axis
    )
  })
  
  output$metadata = renderDataTable({
    metadata_display = meta_data[basename(meta_data$flnm) %in% input$files, ]
    metadata_display
  })
  
  output$log = renderText({
    # metadata_display = meta_data[basename(meta_data$flnm) %in% input$files,]
    # metadata_display$flnm
  })
}
