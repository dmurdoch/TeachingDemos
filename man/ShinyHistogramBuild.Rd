\name{ShinyHistogramBuild}
\alias{ShinyHistogramBuild}
\title{ Interactively Step Through the Construction of a Histogram }
\description{
  Launches a Shiny app that steps through the process of building a
  histogram, one point (or batch of points) at a time, using the
  \code{precip} dataset of average annual precipitation for U.S.
  cities.
}
\usage{
ShinyHistogramBuild(step = 1)
}
\arguments{
  \item{step}{ Initial step number to display (1 to 22). }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  The
  app has a single numeric input, \dQuote{Step}, that controls how
  much of the construction is shown.  Early steps lay out the data and
  the histogram axes/bins; later steps add the data points to the
  histogram one at a time (then in small batches), illustrating how a
  histogram is built up from raw data.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{hist}}, \code{\link{ShinyStemBuild}}, \code{\link{ShinyBoxplotBuild}} }
\examples{
if(interactive()) {
  ShinyHistogramBuild()
}
}
\keyword{ dynamic }
