ShinyPvalueBinomSim <- function(n = 100, p = 0.5, p0 = 0.5,
                                 test = c('approx', 'exact'),
                                 alternative = c('two.sided', 'less', 'greater'),
                                 alpha = 0.05, B = 1000) {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  test <- match.arg(test)
  alternative <- match.arg(alternative)

  runApp(list(
    ui = shinyUI(fluidPage(

      titlePanel("Binomial P-value Simulator"),

      fluidRow(
        plotOutput("pPlot", "100%", height = "500px")
      ),

      fluidRow(
        column(3, numericInput('n', 'Sample Size', value = n, min = 10, max = 10000, step = 1)),
        column(3, numericInput('p', 'p (population)', value = p, min = 0, max = 1, step = 0.01)),
        column(3, numericInput('p0', 'p0 (hypothesis)', value = p0, min = 0, max = 1, step = 0.01)),
        column(3, numericInput('alpha', 'alpha', value = alpha, min = 0, max = 1, step = 0.01))
      ),
      fluidRow(
        column(3, numericInput('B', 'Num Sims', value = B)),
        column(9, ' ')
      ),

      fluidRow(
        column(4, selectInput('tst', 'Test Type', choices = c('approx', 'exact'), selected = test)),
        column(4, selectInput('alt', 'Alternative', choices = c('two.sided', 'less', 'greater'), selected = alternative)),
        column(4, actionButton('refresh', 'Refresh'))
      )

    )),
    server = shinyServer(function(input, output) {

      output$pPlot <- renderPlot({
        input$refresh
        Pvalue.binom.sim(n = input$n, p = input$p,
                         p0 = input$p0, test = input$tst,
                         alternative = input$alt,
                         alpha = input$alpha, B = input$B)
      })

    })
  ))
}
