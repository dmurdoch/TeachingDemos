ShinyHistogramExamp <- function() {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required")
  }
  shiny::runApp(list(
    ui = shiny::shinyUI(shiny::navbarPage(
      "Histogram Examples",

      shiny::tabPanel("Old Faithful Waiting Times",
        shiny::sidebarLayout(
          shiny::sidebarPanel(
            shiny::sliderInput("bins1", "Number of bins:", min = 1, max = 100, value = 30),
            shiny::sliderInput("min1", "Minimum value:", min = 30, max = 43, value = 40, step = 1),
            shiny::sliderInput("max1", "Maximum value:", min = 96, max = 110, value = 100, step = 1)
          ),
          shiny::mainPanel(
            shiny::plotOutput("hist1Plot")
          )
        )
      ),

      shiny::tabPanel("Approval Rating of U.S. Presidents",
        shiny::sidebarLayout(
          shiny::sidebarPanel(
            shiny::sliderInput("bins2", "Number of bins:", min = 1, max = 100, value = 30),
            shiny::sliderInput("min2", "Minimum value:", min = 0, max = 23, value = 0, step = 1),
            shiny::sliderInput("max2", "Maximum value:", min = 87, max = 100, value = 100, step = 1)
          ),
          shiny::mainPanel(
            shiny::plotOutput("hist2Plot")
          )
        )
      ),

      shiny::tabPanel("Car Gas Mileage",
        shiny::sidebarLayout(
          shiny::sidebarPanel(
            shiny::sliderInput("bins3", "Number of bins:", min = 1, max = 100, value = 30),
            shiny::sliderInput("min3", "Minimum value:", min = 7.5, max = 10.4, value = 10, step = 0.1),
            shiny::sliderInput("max3", "Maximum value:", min = 33.9, max = 40, value = 35, step = 0.1)
          ),
          shiny::mainPanel(
            shiny::plotOutput("hist3Plot")
          )
        )
      ),

      shiny::tabPanel("Exam Scores",
        shiny::sidebarLayout(
          shiny::sidebarPanel(
            shiny::sliderInput("bins5", "Number of bins:", min = 1, max = 100, value = 20),
            shiny::sliderInput("min5", "Minimum value:", min = -10, max = 5, value = 0, step = 1),
            shiny::sliderInput("max5", "Maximum value:", min = 100, max = 120, value = 100, step = 1)
          ),
          shiny::mainPanel(
            shiny::plotOutput("hist5Plot")
          )
        )
      ),

      shiny::tabPanel("Constructed Dataset",
        shiny::sidebarLayout(
          shiny::sidebarPanel(
            shiny::sliderInput("bins4", "Number of bins:", min = 1, max = 50, value = 5),
            shiny::sliderInput("min4", "Minimum value:", min = 0, max = 1.8, value = 1, step = 0.01),
            shiny::sliderInput("max4", "Maximum value:", min = 5.8, max = 8, value = 6, step = 0.01)
          ),
          shiny::mainPanel(
            shiny::plotOutput("hist4Plot"),
            shiny::p("Try this with 5 bins and min,max pairs: (1,6), (1.25, 6.25), (1.5, 6.5), and (1.75, 6.75).")
          )
        )
      )

    )),
    server = shiny::shinyServer(function(input, output) {

      output$hist1Plot <- shiny::renderPlot({
        x <- datasets::faithful[, 2]
        bins <- seq(input$min1, input$max1, length.out = input$bins1 + 1)
        hist(x, breaks = bins,
             main = 'Histogram of Old Faithful waiting times', xlab = 'Time')
      })

      output$hist2Plot <- shiny::renderPlot({
        bins <- seq(input$min2, input$max2, length.out = input$bins2 + 1)
        hist(datasets::presidents, breaks = bins,
             main = "Histogram of U.S. Presidents' approval rating",
             xlab = '% Approval')
      })

      output$hist3Plot <- shiny::renderPlot({
        bins <- seq(input$min3, input$max3, length.out = input$bins3 + 1)
        hist(datasets::mtcars$mpg, breaks = bins,
             main = "Histogram of Gas Mileage",
             xlab = 'Miles per Gallon')
      })

      output$hist5Plot <- shiny::renderPlot({
        set.seed(1)
        exam <- rep(seq(10, 100, by = 5), c(2, 3, 4, 6, 7, 2, 10, 5, 9, 15, 20, 25, 50, 75, 100, 200, 300, 310, 100))
        exam <- exam - sample(0:2, length(exam), replace = TRUE, prob = c(0.5, 0.3, 0.2))
        exam <- c(exam, 5)

        bins <- seq(input$min5, input$max5, length.out = input$bins5 + 1)
        hist(exam, breaks = bins,
             main = "Histogram of Exam Scores",
             xlab = 'Percentage')
      })

      output$hist4Plot <- shiny::renderPlot({
        cnstr <- c(3.15, 5.46, 3.28, 4.2, 1.98, 2.28, 3.12, 4.1, 3.42, 3.91, 2.06, 5.53,
                   5.19, 2.39, 1.88, 3.43, 5.51, 2.54, 3.64, 4.33, 4.85, 5.56, 1.89, 4.84, 5.74, 3.22,
                   5.52, 1.84, 4.31, 2.01, 4.01, 5.31, 2.56, 5.11, 2.58, 4.43, 4.96, 1.9, 5.6, 1.92)

        bins <- seq(input$min4, input$max4, length.out = input$bins4 + 1)

        hist(cnstr, breaks = bins,
             main = "Histogram of Constructed Dataset",
             xlab = 'x')
      })

    })
  ))
}
