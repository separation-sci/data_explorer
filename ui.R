
# UI ----------------------------------------------------------------------
ui <- fluidPage(
  titlePanel("Data Explorer"),
  fluidRow(
    #left side panel
    column(
      width = 3,
      
      #side panel for loading files
      wellPanel(
        p(strong("Filters for files:")),
        dateRangeInput(inputId = "date_filter",
                       label = "by date"),
        textInput(inputId = "text_filter",
                  label = "by name"),
        selectInput(
          inputId = "folders",
          label = "by folder",
          choices = dirname(meta_data$flnm) %>% unique(),
          multiple = TRUE,
          selectize = FALSE,
          width = '100%',
          size = 7
        ),
        hr(),
        #TODO: javascript code to hovertext the fullname.
        selectInput(
          inputId = "files",
          label = "Files to plot:",
          choices = NULL,
          multiple = TRUE,
          selectize = FALSE,
          width = '100%',
          size = 10
        ),
        fluidRow(
          actionButton("plot add", "Add to Plot"),
          actionButton("clear", "Erase all")
        )
      )
    ),
    
    #main panel for graphs
    column(
      width = 6,
      wellPanel(plotOutput(outputId = "graphs"),
                position = c("right")),
      # tableOutput(outputId = "meta_data"),
      wellPanel(
        sliderInput(
          inputId = "x_axis",
          label = "x-axis",
          value = c(0, 20),
          min = 0,
          max = 20,
          width = "100%"
        ),
        sliderInput(
          inputId = "y_axis",
          label = "y-axis",
          value = c(0, max(raw_data$RFU * 3) / 4),
          min = 0,
          max = max(raw_data$RFU),
          width = "100%"
        )
      )
    ),
    
    #right side panel for saved graphs
    #TODO: edit saved graphs. remove saved graphs.
    #TODO: export data and graph code
    column(width = 3,
           wellPanel(
             p(strong("Saved graphs:")),
             actionButton("save", "Save Graph")
           ), )
  ),
  
  #metadata for each currently plotted piece of data
  fluidRow(wellPanel(
    p(strong("Meta data:"),
      textOutput("log"),
      tableOutput("metadata"))
  ))
)

