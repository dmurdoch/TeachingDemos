ShinyPutPoints <- function() {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  shiny::runApp(list(
    ui = shiny::shinyUI(
      shiny::fluidPage(
        shiny::titlePanel("Put Points Demo"),

        shiny::fluidRow(
          shiny::plotOutput(
            "ppPlot", "100%", "500px", click = "ppClick"
          )
        ),

        shiny::fluidRow(
          shiny::column(2, "Correlation: ", shiny::verbatimTextOutput("r")),
          shiny::column(2, "Intercept: ", shiny::verbatimTextOutput("b0")),
          shiny::column(2, "Slope: ", shiny::verbatimTextOutput("b1")),
          shiny::column(2, 'RSS:', shiny::verbatimTextOutput('rss')),
          shiny::column(2, 'RSS manual:', shiny::verbatimTextOutput('rssm')),
          shiny::column(2, shiny::actionButton('clear', "Clear Points"))
        ),

        shiny::fluidRow(
          shiny::column(3, shiny::radioButtons('action', 'Action', c('Add', 'Delete', 'Move'), 'Add')),
          shiny::column(4, shiny::checkboxInput('rbox', 'Show r'), shiny::checkboxInput('ls', 'LS line'), shiny::checkboxInput('rect', 'Rectangles'),
                 shiny::checkboxInput('rss.cb', 'Resid. Sum Squares'),
                 shiny::checkboxInput('rssm.cb', 'Manual Line')),
          shiny::column(4, '')
        ),

        shiny::fluidRow(
          shiny::column(2, shiny::numericInput('man.int', "Manual Intercept:", value = 0)),
          shiny::column(2, shiny::numericInput('man.slope', "Manual Slope:", value = 0))
        ),

        shiny::fluidRow(
          shiny::column(1, shiny::numericInput('xmin', 'Minimum x', value = 0)),
          shiny::column(1, shiny::numericInput('xmax', 'Maximum x', value = 10)),
          shiny::column(1, shiny::numericInput('ymin', 'Minimum y', value = 0)),
          shiny::column(1, shiny::numericInput('ymax', 'Maximum y', value = 10)),
          shiny::column(8, ' ')
        )
      )
    ),
    server = shiny::shinyServer(function(input, output, session) {
      xy <- shiny::reactiveValues(x = NULL, y = NULL, w = NULL)

      shiny::observe({
        if (is.null(input$ppClick)) return()
        shiny::isolate({
          if (input$action == 'Add') {
            xy$x <- c(xy$x, input$ppClick$x)
            xy$y <- c(xy$y, input$ppClick$y)
          } else if (input$action == 'Delete') {
            w <- which.min((xy$x - input$ppClick$x)^2 + (xy$y - input$ppClick$y)^2)
            xy$x <- xy$x[-w]
            xy$y <- xy$y[-w]
          } else {
            if (is.null(xy$w)) {
              xy$w <- which.min((xy$x - input$ppClick$x)^2 + (xy$y - input$ppClick$y)^2)
            } else {
              xy$x[xy$w] <- input$ppClick$x
              xy$y[xy$w] <- input$ppClick$y
              xy$w <- NULL
            }
          }
        })
      })

      output$r <- shiny::renderText({
        if (input$rbox & length(xy$x) >= 2) {
          round(cor(xy$x, xy$y), 3)
        } else {
          "  "
        }
      })

      shiny::observe(
        if (input$ls && length(xy$x) >= 2) {
          fit <- lm(xy$y ~ xy$x)
          output$b0 <- shiny::renderText(round(coef(fit)[1], 3))
          output$b1 <- shiny::renderText(round(coef(fit)[2], 3))
        } else {
          output$b0 <- shiny::renderText(' ')
          output$b1 <- shiny::renderText(' ')
        }
      )

      shiny::observe({
        if (input$clear > 0) {
          xy$x <- NULL
          xy$y <- NULL
        }
      })

      output$ppPlot <- shiny::renderPlot({
        plot(xy$x, xy$y, xlab = 'x', ylab = 'y',
             xlim = c(input$xmin, input$xmax),
             ylim = c(input$ymin, input$ymax))
        if (input$ls && length(xy$x) >= 2) {
          abline(tmp <- lm(xy$y ~ xy$x), col = 'blue')
          if (input$rss.cb) {
            segments(x0 = xy$x, y0 = xy$y, y1 = fitted(tmp),
                     col = '#0000ff88')
            output$rss <- shiny::renderText(round(sum(resid(tmp)^2), 2))
          }
        }

        if (input$rssm.cb) {
          abline(input$man.int, input$man.slope, col = 'red')
          if (input$rss.cb & length(xy$x) > 0) {
            segments(x0 = xy$x, y0 = xy$y, y1 = (tmp2 <- input$man.int + input$man.slope * xy$x),
                     col = '#ff000088', lty = 2)
            output$rssm <- shiny::renderText(round(sum((xy$y - tmp2)^2), 2))
          }
        }

        if (!is.null(xy$w)) points(xy$x[xy$w], xy$y[xy$w], pch = 16)
        if (input$rect && length(xy$x) >= 2) {
          x.m <- mean(xy$x)
          y.m <- mean(xy$y)
          cpm <- (xy$x - x.m) * (xy$y - y.m)
          cols <- ifelse(cpm > 0, '#0000ff22', '#ff000022')
          rect(xy$x, xy$y, x.m, y.m, border = NA, col = cols)
        }
      })
    })
  ))
}
