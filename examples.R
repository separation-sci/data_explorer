library(shiny)

ui = fluidPage(
  numericInput("lat", "Latitude", value = 0),
  numericInput("long", "Longitude", value = 0),
  uiOutput("cityControls")
)

server = function(input, output) {
  output$cityControls <- renderUI({
    getNearestCities = function(lat, long) {
      if (lat >3){
        return(3)
      }
    }
    
    cities <- getNearestCities(input$lat, input$long)
    checkboxGroupInput("cities", "Choose Cities", cities)
  })
}

shinyApp(server = server, ui = ui)
