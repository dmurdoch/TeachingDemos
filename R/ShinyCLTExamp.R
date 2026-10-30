ShinyCLTExamp <- function(n = 1) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(

      shiny::titlePanel("Central Limit Theorem Demo"),

      shiny::fluidRow(
        shiny::plotOutput("cltPlot", "100%", height = "500px")
      ),

      shiny::fluidRow(
        shiny::column(2, shiny::numericInput('n', 'Sample Size', value = n)),
        shiny::column(10, ' ')
      )

    )),
    server = shiny::shinyServer(function(input, output, session) {
      output$cltPlot <- shiny::renderPlot({
        clt.examp(input$n)
      })

    })
  ))
}
