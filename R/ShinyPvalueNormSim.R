ShinyPvalueNormSim <- function(n = 50, mu = 10, mu0 = 10, sigma = 3, sigma0 = 3,
                                test = c('z', 't'),
                                alternative = c('two.sided', 'less', 'greater'),
                                alpha = 0.05, B = 1000) {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  test <- match.arg(test)
  alternative <- match.arg(alternative)

  runApp(list(
    ui = shinyUI(fluidPage(

      titlePanel("Normal P-value Simulator"),

      fluidRow(
        plotOutput("pPlot", "100%", height = "500px")
      ),

      fluidRow(
        column(3, numericInput('n', 'Sample Size', value = n, min = 5, max = 10000, step = 1)),
        column(3, numericInput('mu', 'mu (population)', value = mu, min = 0, max = 100, step = 0.1)),
        column(3, numericInput('mu0', 'mu0 (hypothesis)', value = mu0, min = 0, max = 100, step = 0.1)),
        column(3, numericInput('alpha', 'alpha', value = alpha, min = 0, max = 1, step = 0.01))
      ),
      fluidRow(
        column(3, ''),
        column(3, numericInput('sigma', 'sigma (population)', value = sigma)),
        column(3, numericInput('sigma0', 'sigma0 (hypothesis)', value = sigma0)),
        column(3, numericInput('B', 'Num Sims', value = B))
      ),

      fluidRow(
        column(4, selectInput('tst', 'Test Type', choices = c('z', 't'), selected = test)),
        column(4, selectInput('alt', 'Alternative', choices = c('two.sided', 'less', 'greater'), selected = alternative)),
        column(4, actionButton('refresh', 'Refresh'))
      )

    )),
    server = shinyServer(function(input, output) {

      output$pPlot <- renderPlot({
        input$refresh
        Pvalue.norm.sim(n = input$n, mu = input$mu,
                        mu0 = input$mu0, sigma = input$sigma,
                        sigma0 = input$sigma0, test = input$tst,
                        alternative = input$alt,
                        alpha = input$alpha, B = input$B)
      })

    })
  ))
}
