\name{ShinyNormal}
\alias{ShinyNormal}
\title{ Interactively Explore the Normal Distribution }
\description{
  Launches a Shiny app that plots a normal density curve (with
  adjustable mean and standard deviation) and lets you link an x
  value, its corresponding z value, and the area under the curve;
  changing any one of x, z, or area updates the others.  Areas can be
  shown to the left, to the right, in the center, in the tails, or
  over an interval.
}
\usage{
ShinyNormal()
}
\details{
  This function requires the \pkg{shiny} package to be installed.
  Numeric inputs for \code{x}, \code{z}, and \code{Area} are kept
  consistent with each other and with the chosen mean and standard
  deviation; selecting a \dQuote{Fill Area} option shades the
  corresponding region under the curve.  The x-axis range of the plot
  can be reset to +/- 4 standard deviations with the \dQuote{Update x
  Range} button.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{dnorm}}, \code{\link{pnorm}}, \code{\link{qnorm}}, \code{\link{vis.normal}} }
\examples{
if(interactive()) {
  ShinyNormal()
}
}
\keyword{ dynamic }
