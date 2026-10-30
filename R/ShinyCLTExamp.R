ShinyCLTExamp <- function(n = 1) {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  runApp(list(
    ui = shinyUI(fluidPage(

      titlePanel("Central Limit Theorem Demo"),

      fluidRow(
        plotOutput("cltPlot", "100%", height = "500px")
      ),

      fluidRow(
        column(2, numericInput('n', 'Sample Size', value = n)),
        column(10, ' ')
      )

    )),
    server = shinyServer(function(input, output, session) {
      output$cltPlot <- renderPlot({
        clt.examp(input$n)
      })

    })
  ))
}
