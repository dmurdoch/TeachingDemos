ShinySamplingDistMean <- function() {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  set.seed(1)
  pop <- round(rgamma(2000, shape = 1.69, scale = 26 / 1.69), 3)
  pop <- sort(pop)
  pop.mu <- round(mean(pop), 1)
  pop.sd <- round(sd(pop), 1)

  xbar <- numeric(0)
  x <- list()

  runApp(list(
    ui = shinyUI(fluidPage(

      titlePanel("Sampling Distribution"),

      fluidRow(column(12, '')),

      fluidRow(
        plotOutput("sdPlot", "80%", height = "750px")
      ),

      fluidRow(
        column(2, numericInput('n', 'Sample Size', value = 4)),
        column(1, ' '),
        column(2, actionButton('samp1', 'Sample Once')),
        column(2, actionButton('samp5', 'Sample 5')),
        column(2, actionButton('samp100', "Sample 100")),
        column(2, actionButton('samp1000', 'Sample 1,000')),
        column(1, ' ')
      )

    )),
    server = shinyServer(function(input, output, session) {

      output$sdPlot <- renderPlot({
        par(mar = c(4, 4, 2, 1) + 0.1, xpd = FALSE)
        layout(matrix(1:6, ncol = 2), widths = c(3, 1))
        hist(pop, main = '', xlab = 'Population')
        abline(v = pop.mu, col = 'red', lwd = 3)
        segments(pop.mu, 0, pop.mu + pop.sd, 0, col = 'red', lwd = 3)

        if (length(x) == 1) {
          rug(pop[x[[1]]], col = 'blue', ticksize = 0.1)
          plot(hist(pop[x[[1]]], plot = FALSE), xlab = 'Sample', main = '', xlim = c(0, 140))
          tmp.m <- mean(pop[x[[1]]])
          tmp.s <- sd(pop[x[[1]]])
          abline(v = tmp.m, col = 'red', lwd = 3)
          segments(tmp.m, 0, tmp.m + tmp.s, 0, col = 'red', lwd = 3)
        } else if (length(x) > 1) {
          boxplot(x, horizontal = TRUE, main = '', xlab = 'Sample', ylab = '', ylim = c(0, 140))
          abline(v = pop.mu, col = 'red', lty = 2)
        } else {
          plot.new()
        }

        if (length(xbar)) {
          plot(hist(xbar, plot = FALSE), xlab = 'Sampling Distribution', main = '', xlim = c(0, 140))
          tmp.m <- mean(xbar)
          tmp.s <- sd(xbar)
          abline(v = tmp.m, col = 'red', lwd = 3)
          segments(tmp.m, 0, tmp.m + tmp.s, 0, col = 'red', lwd = 3)
        } else {
          plot.new()
        }

        plot.new()
        text(0.25, 0.6, bquote(mu == .(pop.mu)), adj = 0, cex = 3)
        text(0.25, 0.4, bquote(sigma == .(pop.sd)), adj = 0, cex = 3)

        plot.new()
        if (length(x) == 1) {
          tmp.m <- round(mean(pop[x[[1]]]), 1)
          tmp.s <- round(sd(pop[x[[1]]]), 1)
          text(0.25, 0.6, bquote(bar(x) == .(tmp.m)), adj = 0, cex = 3)
          text(0.25, 0.4, bquote(s == .(tmp.s)), adj = 0, cex = 3)
        }

        plot.new()
        if (length(xbar)) {
          tmp.m <- round(mean(xbar), 1)
          tmp.s <- round(sd(xbar), 1)
          text(0.25, 0.7, bquote(bar(bar(x)) == .(tmp.m)), adj = 0, cex = 3)
          text(0.25, 0.3, bquote(s[bar(x)] == .(tmp.s)), adj = 0, cex = 3)
        }

      })

      observe({
        if (input$samp1 > 0) isolate({
          x <<- list(sample(2000, input$n))
          xbar <<- c(xbar, mean(pop[x[[1]]]))
        })
      })

      observe({
        if (input$samp5 > 0) isolate({
          x <<- replicate(5, sample(pop, input$n), simplify = FALSE)
          xbar <<- c(xbar, sapply(x, mean))
        })
      })

      observe({
        if (input$samp100 > 0) isolate({
          x <<- replicate(100, sample(pop, input$n), simplify = FALSE)
          xbar <<- c(xbar, sapply(x, mean))
        })
      })

      observe({
        if (input$samp1000 > 0) isolate({
          x <<- replicate(1000, sample(pop, input$n), simplify = FALSE)
          xbar <<- c(xbar, sapply(x, mean))
        })
      })

      observe({
        tmp <- input$n
        x <<- list()
        xbar <<- numeric(0)
      })

    })
  ))
}
