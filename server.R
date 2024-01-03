# Define server logic required to draw a histogram ----
#BIG TODO: MAKE WORK FOR PA800 plots too

function(input, output) {
  observeEvent(input$selected_folders,
               {
                 updateSelectInput(
                   session = getDefaultReactiveDomain(),
                   input = "selected_files",
                   choices = c("stop realtime plotting", meta_data_for_selection[meta_data_for_selection$folder %in% input$selected_folders,]$file)
                 )
               })
  
  current_plots_saved = reactiveValues(file = c())
  data_to_add = reactiveValues(file = c())
  
  #filters out repeat values when selected_files change. Values can still be plotted in real-time.
  observeEvent(input$selected_files, {
    data_to_add$file = input$selected_files[!(input$selected_files %in% current_plots_saved$file)]
  })
  
  #filters out repeat values when add actionButton is clicked.
  #TODO: still causes double render of the plot
  observeEvent(input$add, {
    data_to_add$file = input$selected_files[!(input$selected_files %in% current_plots_saved$file)]
    current_plots_saved$file = c(data_to_add$file, current_plots_saved$file)
    data_to_add$file = isolate (c())
    
    #clears selection in input$selected_files
    updateSelectInput(
      session = getDefaultReactiveDomain(),
      input = "selected_files",
      selected = "",
      choices = c("stop realtime plotting", meta_data_for_selection[meta_data_for_selection$folder %in% input$selected_folders,]$file)
    )
  })
  
  observeEvent(input$clear, {
    data_to_add$file = c()
    current_plots_saved$file = c()
    
    #clears selection in input$selected_files
    updateSelectInput(
      session = getDefaultReactiveDomain(),
      input = "selected_files",
      selected = "",
      choices = c("stop realtime plotting", meta_data_for_selection[meta_data_for_selection$folder %in% input$selected_folders,]$file)
    )
  })
  
  #DEBUG
  output$debug_area = renderText({
    paste(is.na(raw_data[basename(raw_data$flnm) %in% data_to_add$file, ]$RFU) %>% unique(), sep = "\n")
  })
  
  output$graphs = renderPlot({
    plot_data = data.frame(time = c(0),
                           RFU = c(0))
    realtime_data = data.frame(time = c(0),
                               RFU = c(0))
    
    
    if (length(input$plot_order) > 0) {
      plot_data = raw_data[basename(raw_data$flnm) %in% input$plot_order, ]
    } 
    
    if (length(data_to_add$file) > 0) {
      realtime_data = raw_data[basename(raw_data$flnm) %in% data_to_add$file, ]
    }
    
    plot(
      x = plot_data$time,
      y = plot_data$RFU,
      type = "l",
      xlab = "time",
      ylab = "RFU",
      col = "black",
      xlim = c(input$x_axis_min, input$x_axis_max),
      ylim = c(input$y_axis_min, input$y_axis_max)
    )
    
    lines(x = realtime_data$time,
          y = realtime_data$RFU,
          col = "red")
  })
  
  output$selection_order_list = renderUI({
    labels = current_plots_saved$file[!grepl("stop realtime plotting", current_plots_saved$file)]
    
    rank_list(text = "Drag to re-order",
              labels = labels,
              input_id = "plot_order")
  })
  
  #TODO: make a reactive variable for this content
  output$save_plot = downloadHandler(
    filename = function() {
      paste("params", ".csv", sep = "")
    },
    content = function(file) {
      params = data.frame(
        names = c("x_axis_min",
                  "x_axis_max",
                  "y_axis_min",
                  "y_axis_max"),
        values = c(
          input$x_axis_min,
          input$x_axis_max,
          input$y_axis_min,
          input$y_axis_max
        )
      )
      
      write.csv(params, file, row.names = FALSE)
    }
  )
  
  # output$metadata = renderDataTable({
  #   metadata_display = meta_data[basename(meta_data$flnm) %in% input$selected_files,]
  #   metadata_display
  # })
}
