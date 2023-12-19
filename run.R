library(shiny)
source("ui.R")
source("server.R")

# loading data, which will be filtered and displayed ----------------------

# source("figure_functions_4.R")
# 
# #TODO: dynamic file loading procedure
# file_paths = list.files(
#   path = ".",
#   pattern = ".asc",
#   full.names = TRUE,
#   recursive = TRUE
# )

# meta_data = load_meta_ce(file_paths)
# raw_data = load_data_ce(file_paths, meta_data)

# Create Shiny app ----
# options(shiny.host = '0.0.0.0')
# options(shiny.port = 5050)

shinyApp(ui = ui, server = server)
