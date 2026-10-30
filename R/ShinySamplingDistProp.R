ShinySamplingDistProp <- function() {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  xbar <- numeric(0)
  x <- list()

  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(

      shiny::titlePanel("Sampling Distribution for Proportion"),

      shiny::fluidRow(shiny::column(12, '')),

      shiny::fluidRow(
        shiny::plotOutput("sdPlot", "80%", height = "750px")
      ),

      shiny::fluidRow(
        shiny::column(2, shiny::numericInput('p', 'True Proportion', value = 0.5))
      ),
      shiny::fluidRow(
        shiny::column(2, shiny::numericInput('n', 'Sample Size', value = 20)),
        shiny::column(1, ' '),
        shiny::column(2, shiny::actionButton('samp1', 'Sample Once')),
        shiny::column(2, shiny::actionButton('samp5', 'Sample 5')),
        shiny::column(2, shiny::actionButton('samp100', "Sample 100")),
        shiny::column(2, shiny::actionButton('samp1000', 'Sample 1,000')),
        shiny::column(1, ' ')
      )

    )),
    server = shiny::shinyServer(function(input, output, session) {

      output$sdPlot <- shiny::renderPlot({
        par(mar = c(4, 4, 2, 1) + 0.1, xpd = FALSE)
        layout(matrix(1:6, ncol = 2), widths = c(3, 1))
        barplot(c(1 - input$p, input$p), names = c('No', 'Yes'), main = '', xlab = 'Population')

        if (length(x) == 1) {
          tmp.m <- mean(x[[1]])
          barplot(c(sum(!x[[1]]), sum(x[[1]])), names = c('No', 'Yes'), main = '', xlab = 'Sample', ylim = c(0, input$n))
        } else if (length(x) > 1) {
          tmp.m <- sapply(x, mean)
          plot(tmp.m, xlab = 'Sample', ylab = bquote(hat(p)), ylim = c(0, 1))
          abline(h = input$p, col = 'blue', lty = 2)
        } else {
          plot.new()
        }

        if (length(xbar)) {
          plot(hist(xbar, plot = FALSE), xlab = 'Sampling Distribution', main = '', xlim = c(0, 1))
          tmp.m <- mean(xbar)
          tmp.s <- sd(xbar)
          abline(v = tmp.m, col = 'red', lwd = 3)
          segments(tmp.m, 0, tmp.m + tmp.s, 0, col = 'red', lwd = 3)
        } else {
          plot.new()
        }

        plot.new()

        plot.new()
        if (length(x) == 1) {
          tmp.m <- round(mean(x[[1]]), 3)
          text(0.25, 0.6, bquote(hat(p) == .(tmp.m)), adj = 0, cex = 3)
        }

        plot.new()
        if (length(xbar)) {
          tmp.m <- round(mean(xbar), 3)
          tmp.s <- round(sd(xbar), 3)
          text(0.25, 0.7, bquote(bar(hat(p)) == .(tmp.m)), adj = 0, cex = 3)
          text(0.25, 0.3, bquote(s[hat(p)] == .(tmp.s)), adj = 0, cex = 3)
        }

      })

      shiny::observe({
        if (input$samp1 > 0) shiny::isolate({
          x <<- list(rbinom(input$n, 1, input$p))
          xbar <<- c(xbar, mean(x[[1]]))
        })
      })

      shiny::observe({
        if (input$samp5 > 0) shiny::isolate({
          x <<- replicate(5, rbinom(input$n, 1, input$p), simplify = FALSE)
          xbar <<- c(xbar, sapply(x, mean))
        })
      })

      shiny::observe({
        if (input$samp100 > 0) shiny::isolate({
          x <<- replicate(100, rbinom(input$n, 1, input$p), simplify = FALSE)
          xbar <<- c(xbar, sapply(x, mean))
        })
      })

      shiny::observe({
        if (input$samp1000 > 0) shiny::isolate({
          x <<- replicate(1000, rbinom(input$n, 1, input$p), simplify = FALSE)
          xbar <<- c(xbar, sapply(x, mean))
        })
      })

      shiny::observe({
        tmp <- input$n
        tmp2 <- input$p
        x <<- list()
        xbar <<- numeric(0)
      })

    })
  ))
}
