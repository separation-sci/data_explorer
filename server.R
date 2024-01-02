# Define server logic required to draw a histogram ----
function(input, output) {
  observeEvent(input$folders,
               {
                 updateSelectInput(session = getDefaultReactiveDomain(),
                                   input = "files",
                                   choices = meta_data_for_selection[meta_data_for_selection$folder %in% input$folders,]$file)
               })

  # output$graphs = renderPlot({
  #   if (length(input$files) == 0) {
  #     plot_data = 0
  #   }
  #   else
  #   {
  #     plot_data = raw_data[basename(raw_data$flnm) %in% input$files,]
  #     
  #     plot(
  #       plot_data$time,
  #       plot_data$RFU,
  #       type = "l",
  #       xlab = "time",
  #       ylab = "RFU",
  #       xlim = input$x_axis,
  #       ylim = input$y_axis
  #     )
  #   }
  #   
  #   output$results_basic <- renderPrint({
  #     input$rank_list_basic # This matches the input_id of the rank list
  #   })
  # })
  
  output$selection_order_list = renderUI({
    rank_list(
      text = "Drag to re-order",
      labels = input$files,
      input_id = "rank_list_basic"
    )
  })
  
  # output$metadata = renderDataTable({
  #   metadata_display = meta_data[basename(meta_data$flnm) %in% input$files,]
  #   metadata_display
  # })
}
