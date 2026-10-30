\name{ShinyCLTExamp}
\alias{ShinyCLTExamp}
\title{ Interactively Demonstrate the Central Limit Theorem }
\description{
  Launches a Shiny app wrapping \code{\link{clt.examp}}: it simulates
  several datasets from each of 4 different population shapes for a
  given sample size, and plots histograms of the samples (and of their
  means) with a normal reference curve.
}
\usage{
ShinyCLTExamp(n = 1)
}
\arguments{
  \item{n}{ Initial sample size. }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  With
  the default sample size of 1 the plots show the shapes of the 4
  populations; increasing the sample size shows the sampling
  distribution of the mean becoming more normal, illustrating the
  Central Limit Theorem.  It is best to select and retype the sample
  size value rather than use small increments.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{clt.examp}}, \code{\link{ShinySamplingDistMean}} }
\examples{
if(interactive()) {
  ShinyCLTExamp()
}
}
\keyword{ dynamic }
