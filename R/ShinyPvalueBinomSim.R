ShinyPvalueBinomSim <- function(n = 100, p = 0.5, p0 = 0.5,
                                 test = c('approx', 'exact'),
                                 alternative = c('two.sided', 'less', 'greater'),
                                 alpha = 0.05, B = 1000) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  test <- match.arg(test)
  alternative <- match.arg(alternative)

  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(

      shiny::titlePanel("Binomial P-value Simulator"),

      shiny::fluidRow(
        shiny::plotOutput("pPlot", "100%", height = "500px")
      ),

      shiny::fluidRow(
        shiny::column(3, shiny::numericInput('n', 'Sample Size', value = n, min = 10, max = 10000, step = 1)),
        shiny::column(3, shiny::numericInput('p', 'p (population)', value = p, min = 0, max = 1, step = 0.01)),
        shiny::column(3, shiny::numericInput('p0', 'p0 (hypothesis)', value = p0, min = 0, max = 1, step = 0.01)),
        shiny::column(3, shiny::numericInput('alpha', 'alpha', value = alpha, min = 0, max = 1, step = 0.01))
      ),
      shiny::fluidRow(
        shiny::column(3, shiny::numericInput('B', 'Num Sims', value = B)),
        shiny::column(9, ' ')
      ),

      shiny::fluidRow(
        shiny::column(4, shiny::selectInput('tst', 'Test Type', choices = c('approx', 'exact'), selected = test)),
        shiny::column(4, shiny::selectInput('alt', 'Alternative', choices = c('two.sided', 'less', 'greater'), selected = alternative)),
        shiny::column(4, shiny::actionButton('refresh', 'Refresh'))
      )

    )),
    server = shiny::shinyServer(function(input, output) {

      output$pPlot <- shiny::renderPlot({
        input$refresh
        Pvalue.binom.sim(n = input$n, p = input$p,
                         p0 = input$p0, test = input$tst,
                         alternative = input$alt,
                         alpha = input$alpha, B = input$B)
      })

    })
  ))
}
