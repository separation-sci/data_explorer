library(shiny)
library(tidyverse)
library(sortable)
# source("figure_functions_4.R")

# loading data, which will be filtered and displayed ----------------------

# #TODO: dynamic file loading procedure
# file_paths = list.files(
#   path = ".",
#   pattern = ".asc",
#   full.names = TRUE,
#   recursive = TRUE
# )

# meta_data = load_meta_ce(file_paths)
# raw_data = load_data_ce(file_paths, meta_data)

#reduce the meta_data to an options list of folders and files
meta_data_for_selection = meta_data$flnm %>%
  map(~ str_split_1(., pattern = "/")) %>%
  map_df(~ as.data.frame(t(.[c(-1,-2)])))

colnames(meta_data_for_selection) = c("folder", "file")

# UI ----------------------------------------------------------------------
fluidPage(
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
          inputId = "selected_folders",
          label = "by folder",
          choices = meta_data_for_selection$folder %>% unique(),
          multiple = TRUE,
          selectize = FALSE,
          width = '100%',
          size = 7
        ),
        hr(),
        #TODO: javascript code to hovertext the fullname.
        selectInput(
          inputId = "selected_files",
          label = "Files to plot:",
          choices = NULL,
          multiple = TRUE,
          selectize = FALSE,
          width = '100%',
          size = 10
        ),
        fluidRow(actionButton("add", "Add"),
                 actionButton("clear", "Clear"))
      )
    ),
    
    #main panel for graphs
    column(width = 6,
           wellPanel(
             plotOutput(outputId = "graphs"),
             position = c("right")
           )),
    
    #right side panel for saved graphs
    #TODO: edit saved graphs. remove saved graphs.
    #TODO: export data and graph code
    column(
      width = 3,
      wellPanel(p(strong("Saved graphs:")),
                downloadButton("save_plot", "Save graph params")),
      textOutput(outputId = "debug_area")
    )
  ),
  fluidRow(wellPanel(fluidRow(
    #main panel for parameters
    column(6,
           p(
             strong("Parameters (note duplicates are filtered out):")
           ),
           #TODO make the rank_list update when the "Add" button is clicked
           uiOutput("selection_order_list")),
    column(
      6,
      fluidRow(p(strong(
        "x-axis range (min, max, stack)"
      )),
      column(
        12,
        sliderInput(
          inputId = "x_axis_min_slide",
          label = NULL,
          value = c(0, 20),
          min = 0,
          max = 20
        )
      )),
      fluidRow(
        column(4,
               numericInput(
                 inputId = "x_axis_min",
                 label = NULL,
                 value = 0
               )),
        column(4,
               numericInput(
                 inputId = "x_axis_max",
                 label = NULL,
                 value = 20
               )),
        column(4,
               numericInput(
                 inputId = "x_axis_stack",
                 label = NULL,
                 value = 0
               ))
      ),
      fluidRow(p(strong(
        "y-axis range (min, max, stack)"
      )),
      column(
        12,
        sliderInput(
          inputId = "y_axis_min_slide",
          label = NULL,
          value = c(0, 1000),
          #this should change with the plot
          min = 0,
          max = max(raw_data$RFU)
        )
      )),
      fluidRow(
        column(4,
               numericInput(
                 inputId = "y_axis_min",
                 label = NULL,
                 value = 0
               ))
        ,
        column(4,
               numericInput(
                 inputId = "y_axis_max",
                 label = NULL,
                 value = 100
               )),
        column(4,
               numericInput(
                 inputId = "y_axis_stack",
                 label = NULL,
                 value = 0
               ))
      )
    )
  ))),
  #metadata for each currently plotted piece of data
  fluidRow(wellPanel(
    p(
      strong("Meta data:"),
      textOutput("log"),
      dataTableOutput("metadata")
    )
  ))
)
