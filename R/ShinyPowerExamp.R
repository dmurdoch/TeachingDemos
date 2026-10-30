ShinyPowerExamp <- function(n = 1, sd = 1, diff = 0, alpha = 0.05, xmin = -2, xmax = 4) {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  runApp(list(
    ui = shinyUI(fluidPage(

      titlePanel("Power Example"),

      fluidRow(
        plotOutput("pPlot", "100%", height = "500px")
      ),

      fluidRow(
        column(3, numericInput('n', 'Sample Size', value = n, min = 1, max = 10000, step = 1)),
        column(3, numericInput('sd', 'Standard Deviation', value = sd, min = 0.1, max = 10, step = 0.1)),
        column(3, numericInput('diff', 'Difference', value = diff, min = -10, max = 10, step = 0.1)),
        column(3, numericInput('alpha', 'alpha', value = alpha, min = 0, max = 1, step = 0.01))
      ),

      fluidRow(
        column(3, numericInput('xmin', 'Minimum x', value = xmin)),
        column(3, numericInput('xmax', 'Maximum x', value = xmax)),
        column(6, ' ')
      )

    )),
    server = shinyServer(function(input, output) {

      output$pPlot <- renderPlot({
        power.examp(n = input$n, stdev = input$sd, diff = input$diff,
                    alpha = input$alpha, xmin = input$xmin, xmax = input$xmax
        )
      })

    })
  ))
}
