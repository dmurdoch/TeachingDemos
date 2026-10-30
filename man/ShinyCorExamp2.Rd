\name{ShinyCorExamp2}
\alias{ShinyCorExamp2}
\title{ Interactively Demonstrate Correlation and R-squared with a Shiny App }
\description{
  Launches a Shiny app with a scatterplot of bivariate data and
  linked slider inputs for the correlation and R-squared, along with
  the number of observations and the random seed.
}
\usage{
ShinyCorExamp2(n = 100, seed = 1, initial_cor = 0)
}
\arguments{
  \item{n}{ Initial number of observations to plot. }
  \item{seed}{ Initial random seed used to generate the data. }
  \item{initial_cor}{ Initial value of the correlation slider. }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  It
  is similar to \code{\link{ShinyCorExamp}}, but provides a slider for
  R-squared as well as correlation; moving either slider updates the
  other to match.  New bivariate normal data are generated with the
  specified correlation and plotted as a scatterplot, with the
  correlation and R-squared shown in the plot title.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{cor}}, \code{\link{ShinyCorExamp}}, \code{\link{run.cor2.examp}} }
\examples{
if(interactive()) {
  ShinyCorExamp2()
}
}
\keyword{ dynamic }
