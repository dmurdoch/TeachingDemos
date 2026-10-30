\name{ShinyBoxplotBuild}
\alias{ShinyBoxplotBuild}
\title{ Interactively Step Through the Construction of a Boxplot }
\description{
  Launches a Shiny app that steps through the process of building a
  boxplot (box-and-whiskers plot), using the \code{precip} dataset of
  average annual precipitation for U.S. cities.
}
\usage{
ShinyBoxplotBuild(step = 1)
}
\arguments{
  \item{step}{ Initial step number to display (1 to 13). }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  The
  app has a single numeric input, \dQuote{Step}, that controls how
  much of the construction is shown: setting up the axis, plotting the
  raw data, locating the median, the quartiles and the IQR, computing
  the fences, drawing the box, whiskers, and finally marking potential
  outliers.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{boxplot}}, \code{\link{ShinyHistogramBuild}}, \code{\link{ShinyStemBuild}} }
\examples{
if(interactive()) {
  ShinyBoxplotBuild()
}
}
\keyword{ dynamic }
