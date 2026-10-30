\name{ShinyPutPoints}
\alias{ShinyPutPoints}
\title{ Interactively Build a Scatterplot and Explore Correlation and Regression }
\description{
  Launches a Shiny app with a blank plot that you build up by clicking
  to add points (points can also be deleted or moved).  Options let
  you display the correlation, the least squares regression line, a
  manually specified line, the residual sum of squares, and the
  rectangles used to illustrate the covariance between x and y.
}
\usage{
ShinyPutPoints()
}
\details{
  This function requires the \pkg{shiny} package to be installed.  Use
  the \dQuote{Action} radio buttons to choose whether clicking on the
  plot adds, deletes, or moves a point.  The checkboxes let you show
  the correlation, the least-squares line, the rectangles
  corresponding to \eqn{(x_i - \bar x)(y_i - \bar y)} (used to build
  intuition about correlation), the residual sum of squares for the
  least-squares line, and a manually specified line (with its own
  residual sum of squares) so that you can try to find a better- or
  worse-fitting line by hand.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{lm}}, \code{\link{cor}}, \code{\link{put.points.demo}} }
\examples{
if(interactive()) {
  ShinyPutPoints()
}
}
\keyword{ dynamic }
