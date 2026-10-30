ShinyNormal <- function() {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  runApp(list(
    ui = shinyUI(fluidPage(

      titlePanel("Normal Distribution"),

      fluidRow(column(12, '')),

      fluidRow(
        plotOutput("nPlot", "100%", height = "500px")
      ),

      fluidRow(column(12, '')),

      fluidRow(
        column(2, numericInput("x", "x: ", value = 0, step = 0.01)),
        column(2, numericInput("z", "z: ", value = 0, step = 0.01)),
        column(2, numericInput("p", "Area: ", value = 0.5, step = 0.0001)),
        column(2, numericInput("z2", "z2 (interval): ", value = 0, step = 0.01)),
        column(2, numericInput("x2", "x2 (interval): ", value = 0, step = 0.01)),
        column(2, '')
      ),

      fluidRow(
        column(2, numericInput("mu", "Mean:", value = 0, step = 0.01)),
        column(2, numericInput("sd", "Std. Dev.:", value = 1, step = 0.01)),
        column(8, '')
      ),

      fluidRow(
        column(10, radioButtons('fill', 'Fill Area', c('None', 'Left', 'Center', 'Tails', 'Interval', 'Right'), selected = 'None', inline = TRUE)),
        column(2, '')
      ),

      fluidRow(
        column(2, numericInput('xmin', 'Minimum x', value = -4)),
        column(2, numericInput('xmax', 'Maximum x', value = 4)),
        column(1, ' '),
        column(2, actionButton('updateX', "Update x Range")),
        column(5, ' ')
      )

    )),
    server = shinyServer(function(input, output, session) {

      output$nPlot <- renderPlot({
        xx <- seq(input$xmin, input$xmax, length.out = 250)
        plot(xx, dnorm(xx, input$mu, input$sd), type = 'l', xlab = 'x', ylab = '')
        tmp.x <- (-3:3) * input$sd + input$mu
        axis(3, at = tmp.x, labels = -3:3)
        mtext('z', side = 3, line = 3)

        if (input$fill == 'Left') {
          xx <- seq(input$xmin, input$x, length.out = 250)
          polygon(c(xx[1], xx, xx[250]), c(0, dnorm(xx, input$mu, input$sd), 0), col = 'blue')
        } else if (input$fill == 'Right') {
          xx <- seq(input$x, input$xmax, length.out = 250)
          polygon(c(xx[1], xx, xx[250]), c(0, dnorm(xx, input$mu, input$sd), 0), col = 'blue')
        } else if (input$fill == 'Center') {
          tmp <- range(input$x, input$mu * 2 - input$x)
          xx <- seq(tmp[1], tmp[2], length.out = 250)
          polygon(c(xx[1], xx, xx[250]), c(0, dnorm(xx, input$mu, input$sd), 0), col = 'blue')
        } else if (input$fill == 'Tails') {
          tmp <- range(input$x, input$mu * 2 - input$x)
          xx <- seq(input$xmin, tmp[1], length.out = 250)
          polygon(c(xx[1], xx, xx[250]), c(0, dnorm(xx, input$mu, input$sd), 0), col = 'blue')
          xx <- seq(tmp[2], input$xmax, length.out = 250)
          polygon(c(xx[1], xx, xx[250]), c(0, dnorm(xx, input$mu, input$sd), 0), col = 'blue')
        } else if (input$fill == 'Interval') {
          xx <- seq(input$x, input$x2, length.out = 250)
          polygon(c(xx[1], xx, xx[250]), c(0, dnorm(xx, input$mu, input$sd), 0), col = 'blue')
        }
      })

      observe({
        if (input$updateX > 0) isolate({
          updateNumericInput(session, 'xmin', value = round(input$mu - 4 * input$sd, 2))
          updateNumericInput(session, 'xmax', value = round(input$mu + 4 * input$sd, 2))
        })
      })

      observe({
        tmp2 <- input$fill
        isolate({
          tmp <- input$z
          if (input$fill == 'Left') {
            updateNumericInput(session, 'p', value = round(pnorm(tmp), 4))
          } else if (input$fill == 'Right') {
            updateNumericInput(session, 'p', value = round(pnorm(tmp, lower.tail = FALSE), 4))
          } else if (input$fill == 'Center') {
            updateNumericInput(session, 'p', value = round(2 * (pnorm(abs(tmp)) - 0.5), 4))
          } else if (input$fill == 'Tails') {
            updateNumericInput(session, 'p', value = round(2 * pnorm(min(tmp, -tmp)), 4))
          } else if (input$fill == 'Interval') {
            updateNumericInput(session, 'p', value = round(abs(pnorm(input$z2) - pnorm(tmp)), 4))
          }
        })
      })

      observe({
        tmp <- input$z
        isolate({
          if (abs(input$mu + tmp * input$sd - input$x) > 0.001) {
            updateNumericInput(session, 'x', value = round(input$mu + tmp * input$sd))
          }
          if (input$fill == 'Left') {
            updateNumericInput(session, 'p', value = round(pnorm(tmp), 4))
          } else if (input$fill == 'Right') {
            updateNumericInput(session, 'p', value = round(pnorm(tmp, lower.tail = FALSE), 4))
          } else if (input$fill == 'Center') {
            updateNumericInput(session, 'p', value = round(2 * (pnorm(abs(tmp)) - 0.5), 4))
          } else if (input$fill == 'Tails') {
            updateNumericInput(session, 'p', value = round(2 * pnorm(min(tmp, -tmp)), 4))
          } else if (input$fill == 'Interval') {
            updateNumericInput(session, 'p', value = round(abs(pnorm(input$z2) - pnorm(tmp)), 4))
          }
        })
      })

      observe({
        tmp <- input$z2
        isolate({
          updateNumericInput(session, 'x2', value = round(input$mu + tmp * input$sd))
          if (input$fill == 'Interval') {
            updateNumericInput(session, 'p', value = abs(pnorm(input$z2) - pnorm(input$z)))
          }
        })
      })

      observe({
        tmp <- input$p
        isolate({
          if (input$fill == 'Left') {
            updateNumericInput(session, 'z', value = round(qnorm(tmp), 2))
          } else if (input$fill == 'Right') {
            updateNumericInput(session, 'z', value = round(qnorm(tmp, lower.tail = FALSE), 2))
          } else if (input$fill == 'Center') {
            updateNumericInput(session, 'z', value = round(qnorm(0.5 - tmp / 2), 2))
            updateNumericInput(session, 'z2', value = round(qnorm(0.5 + tmp / 2), 2))
          } else if (input$fill == 'Tails') {
            updateNumericInput(session, 'z', value = round(qnorm(tmp / 2), 2))
            updateNumericInput(session, 'z2', value = round(qnorm(tmp / 2, lower.tail = FALSE), 2))
          }
        })
      })

      observe({
        tmp.m <- input$mu
        tmp.s <- input$sd
        isolate({
          updateNumericInput(session, 'z', value = round((input$x - tmp.m) / tmp.s, 2))
          updateNumericInput(session, 'z2', value = round((input$x2 - tmp.m) / tmp.s, 2))
        })
      })

      observe({
        tmp <- input$x
        isolate(updateNumericInput(session, 'z', value = round((tmp - input$mu) / input$sd, 2)))
      })

      observe({
        tmp <- input$x2
        isolate(updateNumericInput(session, 'z2', value = round((tmp - input$mu) / input$sd, 2)))
      })

    })
  ))
}
