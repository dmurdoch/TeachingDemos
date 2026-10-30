ShinyPowerExamp <- function(n = 1, sd = 1, diff = 0, alpha = 0.05, xmin = -2, xmax = 4) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(

      shiny::titlePanel("Power Example"),

      shiny::fluidRow(
        shiny::plotOutput("pPlot", "100%", height = "500px")
      ),

      shiny::fluidRow(
        shiny::column(3, shiny::numericInput('n', 'Sample Size', value = n, min = 1, max = 10000, step = 1)),
        shiny::column(3, shiny::numericInput('sd', 'Standard Deviation', value = sd, min = 0.1, max = 10, step = 0.1)),
        shiny::column(3, shiny::numericInput('diff', 'Difference', value = diff, min = -10, max = 10, step = 0.1)),
        shiny::column(3, shiny::numericInput('alpha', 'alpha', value = alpha, min = 0, max = 1, step = 0.01))
      ),

      shiny::fluidRow(
        shiny::column(3, shiny::numericInput('xmin', 'Minimum x', value = xmin)),
        shiny::column(3, shiny::numericInput('xmax', 'Maximum x', value = xmax)),
        shiny::column(6, ' ')
      )

    )),
    server = shiny::shinyServer(function(input, output) {

      output$pPlot <- shiny::renderPlot({
        power.examp(n = input$n, stdev = input$sd, diff = input$diff,
                    alpha = input$alpha, xmin = input$xmin, xmax = input$xmax
        )
      })

    })
  ))
}
