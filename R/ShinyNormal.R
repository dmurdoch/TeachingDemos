ShinyNormal <- function() {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(

      shiny::titlePanel("Normal Distribution"),

      shiny::fluidRow(shiny::column(12, '')),

      shiny::fluidRow(
        shiny::plotOutput("nPlot", "100%", height = "500px")
      ),

      shiny::fluidRow(shiny::column(12, '')),

      shiny::fluidRow(
        shiny::column(2, shiny::numericInput("x", "x: ", value = 0, step = 0.01)),
        shiny::column(2, shiny::numericInput("z", "z: ", value = 0, step = 0.01)),
        shiny::column(2, shiny::numericInput("p", "Area: ", value = 0.5, step = 0.0001)),
        shiny::column(2, shiny::numericInput("z2", "z2 (interval): ", value = 0, step = 0.01)),
        shiny::column(2, shiny::numericInput("x2", "x2 (interval): ", value = 0, step = 0.01)),
        shiny::column(2, '')
      ),

      shiny::fluidRow(
        shiny::column(2, shiny::numericInput("mu", "Mean:", value = 0, step = 0.01)),
        shiny::column(2, shiny::numericInput("sd", "Std. Dev.:", value = 1, step = 0.01)),
        shiny::column(8, '')
      ),

      shiny::fluidRow(
        shiny::column(10, shiny::radioButtons('fill', 'Fill Area', c('None', 'Left', 'Center', 'Tails', 'Interval', 'Right'), selected = 'None', inline = TRUE)),
        shiny::column(2, '')
      ),

      shiny::fluidRow(
        shiny::column(2, shiny::numericInput('xmin', 'Minimum x', value = -4)),
        shiny::column(2, shiny::numericInput('xmax', 'Maximum x', value = 4)),
        shiny::column(1, ' '),
        shiny::column(2, shiny::actionButton('updateX', "Update x Range")),
        shiny::column(5, ' ')
      )

    )),
    server = shiny::shinyServer(function(input, output, session) {

      output$nPlot <- shiny::renderPlot({
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

      shiny::observe({
        if (input$updateX > 0) shiny::isolate({
          shiny::updateNumericInput(session, 'xmin', value = round(input$mu - 4 * input$sd, 2))
          shiny::updateNumericInput(session, 'xmax', value = round(input$mu + 4 * input$sd, 2))
        })
      })

      shiny::observe({
        tmp2 <- input$fill
        shiny::isolate({
          tmp <- input$z
          if (input$fill == 'Left') {
            shiny::updateNumericInput(session, 'p', value = round(pnorm(tmp), 4))
          } else if (input$fill == 'Right') {
            shiny::updateNumericInput(session, 'p', value = round(pnorm(tmp, lower.tail = FALSE), 4))
          } else if (input$fill == 'Center') {
            shiny::updateNumericInput(session, 'p', value = round(2 * (pnorm(abs(tmp)) - 0.5), 4))
          } else if (input$fill == 'Tails') {
            shiny::updateNumericInput(session, 'p', value = round(2 * pnorm(min(tmp, -tmp)), 4))
          } else if (input$fill == 'Interval') {
            shiny::updateNumericInput(session, 'p', value = round(abs(pnorm(input$z2) - pnorm(tmp)), 4))
          }
        })
      })

      shiny::observe({
        tmp <- input$z
        shiny::isolate({
          if (abs(input$mu + tmp * input$sd - input$x) > 0.001) {
            shiny::updateNumericInput(session, 'x', value = round(input$mu + tmp * input$sd))
          }
          if (input$fill == 'Left') {
            shiny::updateNumericInput(session, 'p', value = round(pnorm(tmp), 4))
          } else if (input$fill == 'Right') {
            shiny::updateNumericInput(session, 'p', value = round(pnorm(tmp, lower.tail = FALSE), 4))
          } else if (input$fill == 'Center') {
            shiny::updateNumericInput(session, 'p', value = round(2 * (pnorm(abs(tmp)) - 0.5), 4))
          } else if (input$fill == 'Tails') {
            shiny::updateNumericInput(session, 'p', value = round(2 * pnorm(min(tmp, -tmp)), 4))
          } else if (input$fill == 'Interval') {
            shiny::updateNumericInput(session, 'p', value = round(abs(pnorm(input$z2) - pnorm(tmp)), 4))
          }
        })
      })

      shiny::observe({
        tmp <- input$z2
        shiny::isolate({
          shiny::updateNumericInput(session, 'x2', value = round(input$mu + tmp * input$sd))
          if (input$fill == 'Interval') {
            shiny::updateNumericInput(session, 'p', value = abs(pnorm(input$z2) - pnorm(input$z)))
          }
        })
      })

      shiny::observe({
        tmp <- input$p
        shiny::isolate({
          if (input$fill == 'Left') {
            shiny::updateNumericInput(session, 'z', value = round(qnorm(tmp), 2))
          } else if (input$fill == 'Right') {
            shiny::updateNumericInput(session, 'z', value = round(qnorm(tmp, lower.tail = FALSE), 2))
          } else if (input$fill == 'Center') {
            shiny::updateNumericInput(session, 'z', value = round(qnorm(0.5 - tmp / 2), 2))
            shiny::updateNumericInput(session, 'z2', value = round(qnorm(0.5 + tmp / 2), 2))
          } else if (input$fill == 'Tails') {
            shiny::updateNumericInput(session, 'z', value = round(qnorm(tmp / 2), 2))
            shiny::updateNumericInput(session, 'z2', value = round(qnorm(tmp / 2, lower.tail = FALSE), 2))
          }
        })
      })

      shiny::observe({
        tmp.m <- input$mu
        tmp.s <- input$sd
        shiny::isolate({
          shiny::updateNumericInput(session, 'z', value = round((input$x - tmp.m) / tmp.s, 2))
          shiny::updateNumericInput(session, 'z2', value = round((input$x2 - tmp.m) / tmp.s, 2))
        })
      })

      shiny::observe({
        tmp <- input$x
        shiny::isolate(shiny::updateNumericInput(session, 'z', value = round((tmp - input$mu) / input$sd, 2)))
      })

      shiny::observe({
        tmp <- input$x2
        shiny::isolate(shiny::updateNumericInput(session, 'z2', value = round((tmp - input$mu) / input$sd, 2)))
      })

    })
  ))
}
