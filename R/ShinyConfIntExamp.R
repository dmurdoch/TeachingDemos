ShinyConfIntExamp <- function(mean.sim = 100, sd = 10, n = 25, reps = 50,
                               method = c('z', 't', 'both'), conf.level = 0.95) {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  method <- match.arg(method)

  runApp(list(
    ui = shinyUI(fluidPage(

      titlePanel("Confidence Intervals"),

      fluidRow(
        plotOutput("ciPlot", "67%", height = "700px")
      ),

      fluidRow(column(12, ' ')),

      fluidRow(
        column(2, numericInput('mean', 'Population Mean', value = mean.sim)),
        column(2, numericInput('sd', 'Population SD', value = sd)),
        column(2, numericInput('n', 'Sample Size (n)', value = n)),
        column(2, numericInput('reps', 'Reps (num samples)', value = reps)),
        column(2, selectInput('method', 'Method', c('z', 't', 'both'), selected = method)),
        column(2, '')
      ),

      fluidRow(
        column(5, sliderInput('conflev', 'Confidence Level', min = 0.5, max = 0.99, step = 0.01, value = conf.level)),
        column(4, ''),
        column(3, actionButton('newseed', "New Seed"))
      )
    )),
    server = shinyServer(function(input, output) {

      e <- reactiveValues()
      e$curseed <- sample(1000, 1)

      output$ciPlot <- renderPlot({

        set.seed(e$curseed)
        ci.examp(mean.sim = input$mean, sd = input$sd, n = input$n,
                 reps = input$reps, method = input$method,
                 conf.level = input$conflev)
      })

      observe({
        if (input$newseed > 0)
          e$curseed <- sample(1000, 1)
      })

    })
  ))
}
