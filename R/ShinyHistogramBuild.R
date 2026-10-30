ShinyHistogramBuild <- function(step = 1) {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  runApp(list(
    ui = shinyUI(fluidPage(
      titlePanel("Histogram Construction"),
      sidebarLayout(
        sidebarPanel(
          numericInput("step", "Step:", min = 1, max = 22, step = 1, value = step, width = '25%')
        ),
        mainPanel(
          plotOutput("histPlot", height = '800px')
        )
      )
    )),
    server = shinyServer(function(input, output) {

      output$histPlot <- renderPlot({

        pnts <- c(0, 0, 0, 1:10, 15, 20, 25, 30, 40, 50, 60, 70, 70)
        par(mfrow = c(2, 1))
        par(mar = c(0, 0, 2, 0) + 0.1)
        plot.new()
        x <- ((0:69) %% 9) / 10 + 1 / 20
        y <- 1 - (((0:69) %/% 9) / 10 + 1 / 20)
        text(x, y, format(precip), col = ifelse((1:70) > pnts[input$step], 'black', 'grey'),
             cex = 2)
        title(main = 'Average Annual Precipitation for U.S. Cities')

        tmp <- hist(precip, plot = FALSE)
        par(mar = c(4, 4, 0, 0) + 0.1)

        if (input$step >= 2) {
          hist(precip[seq_len(pnts[input$step])], main = '', xlab = 'Precipitation',
               breaks = seq(0, 70, by = 10), ylim = c(0, 25))
        }
        if (input$step >= 3 & input$step < 22) {
          abline(v = seq(0, 70, by = 10), col = '#00ff0088')
        }

      })

    })
  ))
}
