# loading data, which will be filtered and displayed ----------------------

source("figure_functions_4.R")

#TODO: dynamic file loading procedure
file_paths = list.files(
  path = ".",
  pattern = ".asc",
  full.names = TRUE,
  recursive = TRUE
)

# meta_data = load_meta_ce(file_paths)
# raw_data = load_data_ce(file_paths, meta_data)

# UI ----------------------------------------------------------------------
ui <- fluidPage(
  titlePanel("Data Explorer"),
  fluidRow(
    
    #left side panel
    column(
      width = 4,
      
      #side panel for loading files
      wellPanel(
        dateRangeInput(inputId = "date_filter",
                       label = "Date range to filter"),
        textInput(inputId = "text_filter",
                  label = "Text to filter"),
        selectInput(
          inputId = "folders",
          label = "Select Folders",
          choices = dirname(meta_data$flnm) %>% unique(),
          multiple = TRUE,
          selectize = FALSE,
          width = '100%',
          size = 7
        ),
        #TODO: javascript code to hovertext the fullname.
        selectInput(
          inputId = "files",
          label = "Select files to plot",
          choices = NULL,
          multiple = TRUE,
          selectize = FALSE,
          width = '100%',
          size = 10
        ),
        fluidRow(
          actionButton("plot add", "Add to Plot"),
          actionButton("clear", "Erase all")
        ),
        "sldkfjskdfj"
        
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
    column(width = 2,
           wellPanel("saved graphs",
                     actionButton("save", "Save Graph")),)
  ),
  
  #metadata for each currently plotted piece of data
  fluidRow(wellPanel(
    
  ))
)