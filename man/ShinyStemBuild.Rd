\name{ShinyStemBuild}
\alias{ShinyStemBuild}
\title{ Interactively Step Through the Construction of a Stem-and-Leaf Plot }
\description{
  Launches a Shiny app that steps through the process of building a
  stem-and-leaf plot, using the \code{precip} dataset of average
  annual precipitation for U.S. cities.
}
\usage{
ShinyStemBuild(step = 1)
}
\arguments{
  \item{step}{ Initial step number to display (1 to 24). }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  The
  app has a single numeric input, \dQuote{Step}, that controls how
  much of the construction is shown: the data are first rounded, then
  the stems are drawn, then leaves are added one at a time (then in
  batches).  The final steps sort the data within each stem and show
  the sorted, rounded data so you can see that the stem-and-leaf plot
  can be used to recover the (rounded) data.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{stem}}, \code{\link{ShinyHistogramBuild}}, \code{\link{ShinyBoxplotBuild}} }
\examples{
if(interactive()) {
  ShinyStemBuild()
}
}
\keyword{ dynamic }
