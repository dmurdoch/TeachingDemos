ShinyBoxplotBuild <- function(step = 1) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(
      shiny::titlePanel("BoxPlot Construction"),
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::numericInput("step", "Step:", min = 1, max = 13, step = 1, value = step, width = '25%')
        ),
        shiny::mainPanel(
          shiny::plotOutput("bpPlot", height = '300px')
        )
      )
    )),
    server = shiny::shinyServer(function(input, output) {

      med <- median(datasets::precip)
      q1 <- median(datasets::precip[datasets::precip < med])
      q3 <- median(datasets::precip[datasets::precip > med])
      iqr <- q3 - q1
      lf <- q1 - 1.5 * iqr
      uf <- q3 + 1.5 * iqr
      mn <- min(datasets::precip[datasets::precip >= lf])
      mx <- max(datasets::precip[datasets::precip <= uf])

      titles <- c("Set up Axis",
                  "Sort Data",
                  "Find Median",
                  "Find Q1 and Q3",
                  "IQR = 13.7",
                  "q1 - 1.5 * IQR = 0.55",
                  "q3 + 1.5 * IQR = 63.35",
                  "Minimum and Maximum within fences",
                  "Draw Lines",
                  "Draw Box",
                  "Draw Wiskers",
                  "Points for Potential Outliers",
                  ""
      )

      output$bpPlot <- shiny::renderPlot({

        plot.new()
        plot.window(xlim = c(0, 80), ylim = c(-1, 2))
        axis(1)

        if (input$step > 1 & input$step < 13) rug(datasets::precip)
        if (input$step > 2 & input$step < 13) abline(v = med, col = '#00ff0088')
        if (input$step > 3 & input$step < 13) abline(v = c(q1, q3), col = '#0000ff88')
        if (input$step > 5 & input$step < 13) abline(v = lf, col = '#ff000088')
        if (input$step > 6 & input$step < 13) abline(v = uf, col = '#ff000088')
        if (input$step > 7 & input$step < 13) abline(v = c(mn, mx), col = '#ff00ff88')
        if (input$step > 8) {
          segments(x0 = c(mn, q1, med, q3, mx), y0 = c(0.25, 0, 0, 0, 0.25),
                   y1 = c(0.75, 1, 1, 1, 0.75), lwd = c(1, 1, 3, 1, 1))
        }
        if (input$step > 9) {
          rect(q1, 0, q3, 1)
        }
        if (input$step > 10) {
          segments(x0 = c(mn, mx), x1 = c(q1, q3), y0 = 0.5, lty = 2)
        }
        if (input$step > 11) {
          points(datasets::precip[datasets::precip < lf | datasets::precip > uf], rep(0.5, 5))
        }

        title(main = titles[input$step])

      })

    })
  ))
}
