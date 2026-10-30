\name{ShinyHistogramExamp}
\alias{ShinyHistogramExamp}
\title{ Explore How Bin Width and Origin Affect a Histogram's Shape }
\description{
  Launches a Shiny app with 5 tabbed datasets (Old Faithful waiting
  times, U.S. presidential approval ratings, car gas mileage, exam
  scores, and a hand-constructed dataset).  Each tab provides sliders
  for the number of bins and the minimum and maximum values used to
  build the histogram's breakpoints.
}
\usage{
ShinyHistogramExamp()
}
\details{
  This function requires the \pkg{shiny} package to be installed.
  Changing the number of bins, or the starting point (minimum) and
  ending point (maximum) of the breakpoints, shows how much the
  appearance of a histogram can change for the same underlying data,
  which is especially apparent in the \dQuote{Constructed Dataset} tab.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{hist}}, \code{\link{ShinyHistogramBuild}} }
\examples{
if(interactive()) {
  ShinyHistogramExamp()
}
}
\keyword{ dynamic }
