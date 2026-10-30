ShinyConfIntExamp <- function(mean.sim = 100, sd = 10, n = 25, reps = 50,
                               method = c('z', 't', 'both'), conf.level = 0.95) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  method <- match.arg(method)

  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(

      shiny::titlePanel("Confidence Intervals"),

      shiny::fluidRow(
        shiny::plotOutput("ciPlot", "67%", height = "700px")
      ),

      shiny::fluidRow(shiny::column(12, ' ')),

      shiny::fluidRow(
        shiny::column(2, shiny::numericInput('mean', 'Population Mean', value = mean.sim)),
        shiny::column(2, shiny::numericInput('sd', 'Population SD', value = sd)),
        shiny::column(2, shiny::numericInput('n', 'Sample Size (n)', value = n)),
        shiny::column(2, shiny::numericInput('reps', 'Reps (num samples)', value = reps)),
        shiny::column(2, shiny::selectInput('method', 'Method', c('z', 't', 'both'), selected = method)),
        shiny::column(2, '')
      ),

      shiny::fluidRow(
        shiny::column(5, shiny::sliderInput('conflev', 'Confidence Level', min = 0.5, max = 0.99, step = 0.01, value = conf.level)),
        shiny::column(4, ''),
        shiny::column(3, shiny::actionButton('newseed', "New Seed"))
      )
    )),
    server = shiny::shinyServer(function(input, output) {

      e <- shiny::reactiveValues()
      e$curseed <- sample(1000, 1)

      output$ciPlot <- shiny::renderPlot({

        set.seed(e$curseed)
        ci.examp(mean.sim = input$mean, sd = input$sd, n = input$n,
                 reps = input$reps, method = input$method,
                 conf.level = input$conflev)
      })

      shiny::observe({
        if (input$newseed > 0)
          e$curseed <- sample(1000, 1)
      })

    })
  ))
}
