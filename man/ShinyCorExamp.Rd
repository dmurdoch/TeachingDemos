\name{ShinyCorExamp}
\alias{ShinyCorExamp}
\title{ Interactively Demonstrate Correlation with a Shiny App }
\description{
  Launches a Shiny app with a scatterplot of bivariate data and
  slider inputs to interactively change the population correlation,
  the number of observations, and the random seed.
}
\usage{
ShinyCorExamp(n = 100, seed = 1, initial_cor = 0)
}
\arguments{
  \item{n}{ Initial number of observations to plot. }
  \item{seed}{ Initial random seed used to generate the data. }
  \item{initial_cor}{ Initial value of the correlation slider. }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  It
  starts a local Shiny app (via \code{\link[shiny]{runApp}}) with a
  slider for the correlation (ranging from -1 to 1), a numeric input
  for the number of observations, and a numeric input for the random
  seed.  Whenever an input changes, new bivariate normal data are
  generated with the specified correlation and plotted as a
  scatterplot, with the correlation value shown in the plot title.

  This is useful for building intuition about how scatterplots look
  for different values of the correlation coefficient.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{cor}}, \code{\link{run.cor.examp}} }
\examples{
if(interactive()) {
  ShinyCorExamp()
}
}
\keyword{ dynamic }
