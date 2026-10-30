ShinyCorExamp2 <- function(n=100, seed=1, initial_cor=0) {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  runApp(list(
    ui = shinyUI(fluidPage(
      titlePanel("Correlation Example"),
      sidebarLayout(
        sidebarPanel(
          sliderInput("r", "Correlation:", min = -1, max = 1, step = 0.01, value = initial_cor),
          sliderInput("r2", "R-Squared", min = 0, max = 1, step = 0.01, value = initial_cor^2),
          numericInput('n', "Number of Observations:", n, min = 10, step = 10),
          numericInput('seed', "Seed:", seed, min = 1, max = 255)
        ),
        mainPanel(
          plotOutput("corPlot")
        )
      )
    )),
    server = shinyServer(function(input, output, session) {

      observe({
        updateSliderInput(session, 'r', value = isolate(ifelse(input$r < 0, -1, 1)) * sqrt(input$r2))
      })

      observe({
        updateSliderInput(session, 'r2', value = input$r^2)
      })

      output$corPlot <- renderPlot(
        {
          set.seed(input$seed)
          x <- scale(matrix(rnorm(2 * input$n, 0, 1), ncol = 2, byrow = TRUE))
          x <- x %*% solve(chol(cor(x)))
          xr <- range(x, -x)

          if (input$r == 1) {
            cmat <- matrix(c(1, 0, 1, 0), 2)
          } else if (input$r == -1) {
            cmat <- matrix(c(1, 0, -1, 0), 2)
          } else {
            cmat <- chol(matrix(c(1, input$r, input$r, 1), 2))
          }
          new.x <- x %*% cmat

          plot(new.x, xlab = 'x', ylab = 'y', xlim = xr, ylim = xr, asp = 1)
          tmp.r <- round(input$r, 3)
          tmp.r2 <- round(input$r2, 3)
          title(bquote(atop(r == .(tmp.r), R^2 == .(tmp.r2))))
        },
        width = 600,
        height = 600
      )
    })
  ))
}
