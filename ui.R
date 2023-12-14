# loading data, which will be filtered and displayed ----------------------

source("~/Documents/rshiny_test/figure_functions_4.R")

file_paths = list.files(
  path = ".",
  pattern = ".asc",
  full.names = TRUE,
  recursive = TRUE
)

# meta_data = load_meta_ce(file_paths)
# raw_data = load_data_ce(file_paths, meta_data)

# UI ----------------------------------------------------------------------
ui <- fluidPage(titlePanel("Data Explorer"),
                
                verticalLayout(
                  mainPanel(
                    flowLayout(
                      dateRangeInput(inputId = "date_filter",
                                     label = "Date range to filter"),
                      actionButton("date_button", "align me")
                    ),
                    flowLayout(
                      textInput(inputId = "text_filter",
                                label = "Text to filter"),
                      actionButton("text_button", "me too")
                    ),
                    selectInput(
                      inputId = "folders",
                      label = "Select Folders",
                      choices = dirname(meta_data$flnm) %>% unique(),
                      multiple = TRUE,
                      selectize = FALSE,
                      width = '100%',
                      size = 7
                    ),
                    selectInput(
                      inputId = "files",
                      label = "Select files to plot",
                      choices = NULL,
                      multiple = TRUE,
                      selectize = FALSE,
                      width = '100%',
                      size = 10
                    ),
                    actionButton("plot", "Lock me in"),
                    actionButton("clear", "Erase everything"),
                    textOutput("log")
                  ),
                  # Main panel for displaying outputs ----
                  mainPanel(plotOutput(outputId = "graphs"),
                            position = c("right")),
                  # tableOutput(outputId = "meta_data"),
                  mainPanel(
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
                ))
