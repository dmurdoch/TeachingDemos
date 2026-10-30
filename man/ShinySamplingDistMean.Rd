\name{ShinySamplingDistMean}
\alias{ShinySamplingDistMean}
\title{ Interactively Demonstrate the Sampling Distribution of the Mean }
\description{
  Launches a Shiny app that shows a skewed \dQuote{population}
  distribution along with its mean and standard deviation.  Clicking
  \dQuote{Sample Once} draws a sample and shows it along with its
  mean; sampling in batches accumulates many sample means into a
  histogram approximating the sampling distribution of the mean.
}
\usage{
ShinySamplingDistMean()
}
\details{
  This function requires the \pkg{shiny} package to be installed.  Set
  the sample size, then use the \dQuote{Sample Once}, \dQuote{Sample
  5}, \dQuote{Sample 100}, or \dQuote{Sample 1,000} buttons to draw
  samples from the (fixed) skewed population.  A single sample is
  shown as a histogram; multiple individual samples are shown as
  boxplots.  All sampled means accumulate into the sampling
  distribution histogram at the bottom.  Changing the sample size
  resets the accumulated samples.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{ShinySamplingDistProp}}, \code{\link{clt.examp}} }
\examples{
if(interactive()) {
  ShinySamplingDistMean()
}
}
\keyword{ dynamic }
