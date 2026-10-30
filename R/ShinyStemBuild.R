ShinyStemBuild <- function(step = 1) {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::fluidPage(
      shiny::titlePanel("Stem and Leaf Construction"),
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::numericInput("step", "Step:", min = 1, max = 24, step = 1, value = step, width = '25%')
        ),
        shiny::mainPanel(
          shiny::plotOutput("stemPlot", height = '800px')
        )
      )
    )),
    server = shiny::shinyServer(function(input, output) {

      output$stemPlot <- shiny::renderPlot({

        pnts <- c(0, 0, 0, 0, 1:10, 15, 20, 25, 30, 40, 50, 60, 70, 70, 0)
        plts <- c(
          "", "", "",
          "  0 | \n  1 | \n  2 | \n  3 | \n  4 | \n  5 | \n  6 | ", # 0
          "  0 |\n  1 | \n  2 | \n  3 | \n  4 | \n  5 | \n  6 | 7", # 1
          "  0 | \n  1 | \n  2 | \n  3 | \n  4 | \n  5 | 5\n  6 | 7", # 2
          "  0 | 7\n  1 | \n  2 | \n  3 | \n  4 | \n  5 | 5\n  6 | 7", # 3
          "  0 | 7\n  1 | \n  2 | \n  3 | \n  4 | 8\n  5 | 5\n  6 | 7", # 4
          "  0 | 7\n  1 | 4\n  2 | \n  3 | \n  4 | 8\n  5 | 5\n  6 | 7", # 5
          "  0 | 7\n  1 | 47\n  2 | \n  3 | \n  4 | 8\n  5 | 5\n  6 | 7", # 6
          "  0 | 7\n  1 | 47\n  2 | 1\n  3 | \n  4 | 8\n  5 | 5\n  6 | 7", # 7
          "  0 | 7\n  1 | 473\n  2 | 1\n  3 | \n  4 | 8\n  5 | 5\n  6 | 7", # 8
          "  0 | 7\n  1 | 473\n  2 | 1\n  3 | \n  4 | 83\n  5 | 5\n  6 | 7", # 9
          "  0 | 7\n  1 | 473\n  2 | 1\n  3 | \n  4 | 830\n  5 | 5\n  6 | 7", # 10
          "  0 | 7\n  1 | 473\n  2 | 13\n  3 | 9\n  4 | 8308\n  5 | 54\n  6 | 7", # 15
          "  0 | 7\n  1 | 4732\n  2 | 13\n  3 | 94591\n  4 | 8308\n  5 | 54\n  6 | 70", # 20
          "  0 | 7\n  1 | 4732\n  2 | 13\n  3 | 945911\n  4 | 8308312\n  5 | 547\n  6 | 70", # 25
          "  0 | 7\n  1 | 4732\n  2 | 136\n  3 | 945911120\n  4 | 83083122\n  5 | 547\n  6 | 70", # 30
          "  0 | 778\n  1 | 47325\n  2 | 136\n  3 | 94591112076063\n  4 | 8308312296\n  5 | 547\n  6 | 70", # 40
          "  0 | 778\n  1 | 473256\n  2 | 136\n  3 | 94591112076063695718\n  4 | 8308312296032\n  5 | 547\n  6 | 70", # 50
          "  0 | 7788\n  1 | 473256\n  2 | 1365\n  3 | 9459111207606369571866\n  4 | 8308312296032036968\n  5 | 547\n  6 | 70", # 60
          "  0 | 7788\n  1 | 473256575\n  2 | 13659\n  3 | 945911120760636957186629\n  4 | 8308312296032036968531\n  5 | 5479\n  6 | 70", # 70
          "  0 | 7788\n  1 | 234555677\n  2 | 13569\n  3 | 001111233455666667789999\n  4 | 0001123333333566688999\n  5 | 5579\n  6 | 07", # 70 sorted
          "  0 | 7788\n  1 | 234555677\n  2 | 13569\n  3 | 001111233455666667789999\n  4 | 0001123333333566688999\n  5 | 5579\n  6 | 07" # 70 sorted
        )

        par(mfrow = c(2, 1))
        par(mar = c(0, 0, 2, 0) + 0.1)
        plot.new()
        x <- ((0:69) %% 9) / 10 + 1 / 20
        y <- 1 - (((0:69) %/% 9) / 10 + 1 / 20)
        tmptxt <- if (input$step > 1) {
          if (input$step == 24) {
            sort(round(datasets::precip))
          } else {
            format(round(datasets::precip))
          }
        } else {
          format(datasets::precip)
        }
        text(x, y, tmptxt, col = ifelse((1:70) > pnts[input$step], 'black', 'grey'),
             cex = 2, adj = 0, family = 'mono')
        if (input$step == 3 | input$step == 4) {
          text(x, y, format(floor(round(datasets::precip) / 10)), col = 'red', cex = 2, adj = 0,
               family = 'mono')
        }
        title(main = 'Average Annual Precipitation for U.S. Cities')

        plot.new()
        text(0, 1, plts[input$step], cex = 2, adj = c(0, 1), family = 'mono')

      })

    })
  ))
}
