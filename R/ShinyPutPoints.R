ShinyPutPoints <- function() {
  if (!require(shiny)) {
    stop("The shiny package is required")
  }
  runApp(list(
    ui = shinyUI(
      fluidPage(
        titlePanel("Put Points Demo"),

        fluidRow(
          plotOutput(
            "ppPlot", "100%", "500px", click = "ppClick"
          )
        ),

        fluidRow(
          column(2, "Correlation: ", verbatimTextOutput("r")),
          column(2, "Intercept: ", verbatimTextOutput("b0")),
          column(2, "Slope: ", verbatimTextOutput("b1")),
          column(2, 'RSS:', verbatimTextOutput('rss')),
          column(2, 'RSS manual:', verbatimTextOutput('rssm')),
          column(2, actionButton('clear', "Clear Points"))
        ),

        fluidRow(
          column(3, radioButtons('action', 'Action', c('Add', 'Delete', 'Move'), 'Add')),
          column(4, checkboxInput('rbox', 'Show r'), checkboxInput('ls', 'LS line'), checkboxInput('rect', 'Rectangles'),
                 checkboxInput('rss.cb', 'Resid. Sum Squares'),
                 checkboxInput('rssm.cb', 'Manual Line')),
          column(4, '')
        ),

        fluidRow(
          column(2, numericInput('man.int', "Manual Intercept:", value = 0)),
          column(2, numericInput('man.slope', "Manual Slope:", value = 0))
        ),

        fluidRow(
          column(1, numericInput('xmin', 'Minimum x', value = 0)),
          column(1, numericInput('xmax', 'Maximum x', value = 10)),
          column(1, numericInput('ymin', 'Minimum y', value = 0)),
          column(1, numericInput('ymax', 'Maximum y', value = 10)),
          column(8, ' ')
        )
      )
    ),
    server = shinyServer(function(input, output, session) {
      xy <- reactiveValues(x = NULL, y = NULL, w = NULL)

      observe({
        if (is.null(input$ppClick)) return()
        isolate({
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

      output$r <- renderText({
        if (input$rbox & length(xy$x) >= 2) {
          round(cor(xy$x, xy$y), 3)
        } else {
          "  "
        }
      })

      observe(
        if (input$ls && length(xy$x) >= 2) {
          fit <- lm(xy$y ~ xy$x)
          output$b0 <- renderText(round(coef(fit)[1], 3))
          output$b1 <- renderText(round(coef(fit)[2], 3))
        } else {
          output$b0 <- renderText(' ')
          output$b1 <- renderText(' ')
        }
      )

      observe({
        if (input$clear > 0) {
          xy$x <- NULL
          xy$y <- NULL
        }
      })

      output$ppPlot <- renderPlot({
        plot(xy$x, xy$y, xlab = 'x', ylab = 'y',
             xlim = c(input$xmin, input$xmax),
             ylim = c(input$ymin, input$ymax))
        if (input$ls && length(xy$x) >= 2) {
          abline(tmp <- lm(xy$y ~ xy$x), col = 'blue')
          if (input$rss.cb) {
            segments(x0 = xy$x, y0 = xy$y, y1 = fitted(tmp),
                     col = '#0000ff88')
            output$rss <- renderText(round(sum(resid(tmp)^2), 2))
          }
        }

        if (input$rssm.cb) {
          abline(input$man.int, input$man.slope, col = 'red')
          if (input$rss.cb & length(xy$x) > 0) {
            segments(x0 = xy$x, y0 = xy$y, y1 = (tmp2 <- input$man.int + input$man.slope * xy$x),
                     col = '#ff000088', lty = 2)
            output$rssm <- renderText(round(sum((xy$y - tmp2)^2), 2))
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
