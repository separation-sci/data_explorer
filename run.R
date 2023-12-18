library(shiny)
source("ui.R")
source("server.R")

# Create Shiny app ----
# options(shiny.host = '0.0.0.0')
# options(shiny.port = 5050)
shinyApp(ui = ui, server = server)
