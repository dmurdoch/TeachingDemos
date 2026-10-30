ShinyPvalueNormSim <- function(n = 50, mu = 10, mu0 = 10, sigma = 3, sigma0 = 3,
                                test = c('z', 't'),
                                alternative = c('two.sided', 'less', 'greater'),
                                alpha = 0.05, B = 1000) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  test <- match.arg(test)
  alternative <- match.arg(alternative)

  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(

      shiny::titlePanel("Normal P-value Simulator"),

      shiny::fluidRow(
        shiny::plotOutput("pPlot", "100%", height = "500px")
      ),

      shiny::fluidRow(
        shiny::column(3, shiny::numericInput('n', 'Sample Size', value = n, min = 5, max = 10000, step = 1)),
        shiny::column(3, shiny::numericInput('mu', 'mu (population)', value = mu, min = 0, max = 100, step = 0.1)),
        shiny::column(3, shiny::numericInput('mu0', 'mu0 (hypothesis)', value = mu0, min = 0, max = 100, step = 0.1)),
        shiny::column(3, shiny::numericInput('alpha', 'alpha', value = alpha, min = 0, max = 1, step = 0.01))
      ),
      shiny::fluidRow(
        shiny::column(3, ''),
        shiny::column(3, shiny::numericInput('sigma', 'sigma (population)', value = sigma)),
        shiny::column(3, shiny::numericInput('sigma0', 'sigma0 (hypothesis)', value = sigma0)),
        shiny::column(3, shiny::numericInput('B', 'Num Sims', value = B))
      ),

      shiny::fluidRow(
        shiny::column(4, shiny::selectInput('tst', 'Test Type', choices = c('z', 't'), selected = test)),
        shiny::column(4, shiny::selectInput('alt', 'Alternative', choices = c('two.sided', 'less', 'greater'), selected = alternative)),
        shiny::column(4, shiny::actionButton('refresh', 'Refresh'))
      )

    )),
    server = shiny::shinyServer(function(input, output) {

      output$pPlot <- shiny::renderPlot({
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
