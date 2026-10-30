\name{ShinyConfIntExamp}
\alias{ShinyConfIntExamp}
\title{ Interactively Demonstrate Confidence Intervals }
\description{
  Launches a Shiny app wrapping \code{\link{ci.examp}}: it draws
  several samples from a specified normal population and plots the
  confidence interval computed from each sample, along with the true
  population mean, so you can see what proportion of the intervals
  contain the true value.
}
\usage{
ShinyConfIntExamp(mean.sim = 100, sd = 10, n = 25, reps = 50,
                   method = c("z", "t", "both"), conf.level = 0.95)
}
\arguments{
  \item{mean.sim}{ Initial population mean. }
  \item{sd}{ Initial population standard deviation. }
  \item{n}{ Initial sample size for each simulated sample. }
  \item{reps}{ Initial number of samples (confidence intervals) to draw. }
  \item{method}{ Initial method: \code{"z"} uses the population SD,
    \code{"t"} estimates the standard error from each sample, and
    \code{"both"} shows both intervals together for comparison. }
  \item{conf.level}{ Initial confidence level. }
}
\details{
  This function requires the \pkg{shiny} package to be installed.  Use
  the \dQuote{New Seed} button to redraw a fresh set of samples with
  the current settings.
}
\value{
  Called for the side effect of running a Shiny app.  Returns whatever
  \code{\link[shiny]{runApp}} returns (typically invisible \code{NULL}
  when the app is stopped).
}
\author{ Greg Snow \email{538280@gmail.com} }
\seealso{ \code{\link{ci.examp}} }
\examples{
if(interactive()) {
  ShinyConfIntExamp()
}
}
\keyword{ dynamic }
